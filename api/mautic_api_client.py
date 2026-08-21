"""
Client Python para integração com a API v5/v4 do Mautic.
Utilizado para criação/atualização de contatos e atribuição de segmentos BJ Sports.
"""

import os
import requests

class MauticApiClient:
    def __init__(self, base_url=None, username=None, password=None):
        self.base_url = (base_url or os.getenv("MAUTIC_URL", "http://localhost:8080")).rstrip('/')
        self.username = username or os.getenv("MAUTIC_ADMIN_EMAIL", "admin@bjsports.com.br")
        self.password = password or os.getenv("MAUTIC_ADMIN_PASSWORD", "secret")
        self.auth = (self.username, self.password)

    def create_contact(self, email: str, firstname: str = "", lastname: str = "", extra_fields: dict = None):
        """Cria ou atualiza um contato no Mautic."""
        url = f"{self.base_url}/api/contacts/new"
        payload = {
            "email": email,
            "firstname": firstname,
            "lastname": lastname
        }
        if extra_fields:
            payload.update(extra_fields)

        response = requests.post(url, json=payload, auth=self.auth, timeout=10)
        response.raise_for_status()
        return response.json()

    def add_contact_to_segment(self, segment_id: int, contact_id: int):
        """Adiciona um contato a um segmento específico."""
        url = f"{self.base_url}/api/segments/{segment_id}/contact/{contact_id}/add"
        response = requests.post(url, json={}, auth=self.auth, timeout=10)
        response.raise_for_status()
        return response.json()


if __name__ == "__main__":
    client = MauticApiClient()
    print("MauticApiClient inicializado para:", client.base_url)
