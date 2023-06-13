terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.9.1"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "samplerepo" {
  name        = "samplerepo"
  description = "sample repo created using tf"
  visibility = "public"
}
