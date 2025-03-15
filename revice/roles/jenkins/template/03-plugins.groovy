import jenkins.model.*
import hudson.PluginWrapper

def pluginsToInstall = [
    'workflow-multibranch',
    'git',
    'pipeline-stage-view',
    'blueocean',
    'multibranch-scan-webhook-trigger'
]

// Reference Jenkins Plugin Manager and Update Center
def pluginManager = Jenkins.instance.pluginManager
def updateCenter = Jenkins.instance.updateCenter

// Loop through each plugin and install if not already installed
pluginsToInstall.each { pluginName ->
  // Check if the plugin is already installed
  if (!pluginManager.getPlugin(pluginName)) {
    println "Installing plugin: ${pluginName}"
    def plugin = updateCenter.getPlugin(pluginName)

    if (plugin) {
      // Deploy plugin (install it)
      plugin.deploy(true).get() // 'get()' waits for the installation to complete
      println "Successfully installed ${pluginName}."
    } else {
      println "Plugin ${pluginName} not found in the Update Center."
    }
  } else {
    println "Plugin ${pluginName} is already installed."
  }
}