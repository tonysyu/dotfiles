-- Configure jdtls to use Java 25 while keeping system Java 17
local jdtls = require('jdtls')

-- Use Java 25 for jdtls runtime
local java_25_home = '/opt/homebrew/opt/openjdk'

-- Find jdtls installation (installed via Mason)
local mason_path = vim.fn.stdpath('data') .. '/mason'
local jdtls_path = mason_path .. '/packages/jdtls'
local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Project-specific workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

local config = {
  cmd = {
    java_25_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher,
    '-configuration', jdtls_path .. '/config_mac',
    '-data', workspace_dir,
  },
  root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
  settings = {
    java = {
      -- Configure multiple Java runtimes
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/Library/Java/JavaVirtualMachines/jdk17.0.16.jdk/Contents/Home",
          },
          {
            name = "JavaSE-25",
            path = java_25_home,
            default = true,
          },
        }
      }
    }
  },
  init_options = {
    bundles = {}
  },
}

jdtls.start_or_attach(config)
