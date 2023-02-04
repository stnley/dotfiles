local has_jdtls, jdtls = pcall(require, "jdtls")

local config = require("stnley.lsp")

if not has_jdtls then
  return
end

local system_install = "/usr/share/java/jdtls"
local root_markers = { ".gradlew", ".git", "pom.xml" }
local project_dir = require("jdtls.setup").find_root(root_markers)
local data_dir = os.getenv("XDG_DATA_HOME")
local workspace_dir = data_dir .. "/eclipse/" .. vim.fn.fnamemodify(project_dir, ":p:h:t")

config.cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  -- added based on arch jdtls install
  "-Dosgi.checkConfiguration=true",
  "-Dosgi.sharedConfiguration.area=" .. system_install .. "/config_linux",
  "-Dosgi.sharedConfiguration.area.readOnly=true",
  "-Dosgi.configuration.cascaded=true",
  -- /added based on arch jdtls install
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  -- TODO: idk what these flags mean
  "-Xms1g",
  -- "-Xmx4g", ?
  -- "-Xmx2G" ?
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "-jar",
  vim.fn.glob(system_install .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
  "-data",
  workspace_dir,
}

config.root_dir = project_dir
config.settings = {
  java = {
    referencesCodeLens = { enabled = false },
    implementationsCodeLens = { enabled = false },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-1.8",
          path = "/usr/lib/jvm/java-8-openjdk/",
        },
        {
          name = "JavaSE-11",
          path = "/usr/lib/jvm/java-11-openjdk/",
        },
        {
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-openjdk/",
        },
        {
          name = "JavaSE-19",
          path = "/usr/lib/jvm/java-19-openjdk/",
        },
      },
    },
  },
}

local home = os.getenv("HOME")
local bundles_dir = home .. "/.local/lib"
local bundles = {
  vim.fn.glob(
    bundles_dir .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
    1
  ),
  vim.fn.glob(bundles_dir .. "/vscode-java-test/server/*.jar", 1),
}

local extendedClientCapabilities = jdtls.extendedClientCapabilities
config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

local common_on_attach = config.on_attach
config.on_attach = function(client, bufnr)
  -- TODO: dap is still not automatically setting up.
  -- it does work if I run the refresh dap config command
  jdtls.setup_dap()
  jdtls.setup.add_commands()
  common_on_attach(client, bufnr)
end

jdtls.start_or_attach(config)
