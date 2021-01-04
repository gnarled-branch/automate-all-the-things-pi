resource "kubernetes_service" "app" {
  metadata {
    name = var.app
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.metadata.0.labels.app
    }
    port {
      node_port   = 30201
      port        = 80
      target_port = 3000
    }
    type = "NodePort"
  }
}
