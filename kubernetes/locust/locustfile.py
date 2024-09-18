from locust import HttpUser, TaskSet, task, between

class UserBehavior(TaskSet):
    @task
    def index(self):
        self.client.get("/")  # Enviar una petición GET a la raíz del servidor

    @task
    def about(self):
        self.client.get("/about")  # Enviar una petición GET a la ruta /about

class WebsiteUser(HttpUser):
    tasks = [UserBehavior]
    wait_time = between(1, 5)  # Simula usuarios esperando entre 1 y 5 segundos entre solicitudes
