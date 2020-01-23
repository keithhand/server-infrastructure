resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "self"
  }
}

resource "kubernetes_secret" "docker_login" {
  metadata {
    name = "docker"
  }

  data = {
    ".dockerconfigjson" = file("~/.docker/config.json")
  }

  type = "kubernetes.io/dockerconfigjson"
}

//resource "kubernetes_pod" "pod" {
//  metadata {
//    name = "personal-webpage-pod"
//    namespace = "self"
//    labels = {
//      App = "personal-webpage"
//    }
//  }
//
//  spec {
//    container {
//      name = "personal-webpage-app"
//      image = "tsiom/personal-webpage:v2.0"
//    }
//  }
//}

resource "kubernetes_deployment" "deploy" {
  metadata {
    name = "personal-webpage-app"
    namespace = "self"
    labels = {
      App = "personal-webpage"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        App = "personal-webpage"
      }
    }

    template {
      metadata {
        name = "personal-webpage-app"
        namespace = "self"
        labels = {
          App = "personal-webpage"
        }
      }
      spec {
        container {
          image = "tsiom/personal-webpage:v2.0"
          name = "personal-webpage-app"
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name = "personal-webpage-service"
    namespace = "self"
  }
  spec {
    selector = {
      App = "personal-webpage"
    }
    port {
      port = 80
      target_port = 8000
    }

    type = "NodePort"
  }
}
