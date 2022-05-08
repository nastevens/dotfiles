require("filetype").setup {
  overrides = {
    extensions = {
      bb = "bitbake",
      scad = "openscad",
      tf = "terraform",
    },
    literal = {
      Jenkinsfile = "groovy",
    },
    complex = {
      [".*/%.aws/config"] = "conf",
      [".*/Dockerfile[^/]*"] = "dockerfile",
      [".*/hub%-os/.*%.inc"] = "bitbake",
    },
  }
}
