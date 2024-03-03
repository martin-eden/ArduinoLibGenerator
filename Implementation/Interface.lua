-- ArduinoLibGenerator API

-- Nothing to see here. Core code at "Internals/Generate.lua".

return
  {
    -- Configuration defaults
    ResultsDir = 'Results/',
    ConfigurationFilename = '',
    -- Main
    Run = request('Run'),
    -- Help texts for CLI
    GetUsageText = request('GetUsageText'),
    GetConfigurationExample = request('GetConfigurationExample'),
  }
