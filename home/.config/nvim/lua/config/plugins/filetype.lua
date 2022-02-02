require("filetype").setup {
  overrides = {
    literal = {
      Jenkinsfile = "groovy",
    },
    complex = {
      ["%.aws/config"] = "conf",
    },
  }
}
