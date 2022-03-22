require("filetype").setup {
  overrides = {
    extensions = {
      tf = "terraform",
    },
    literal = {
      Jenkinsfile = "groovy",
    },
    complex = {
      ["%.aws/config"] = "conf",
      ["Dockerfile"] = "dockerfile",
    },
  }
}
