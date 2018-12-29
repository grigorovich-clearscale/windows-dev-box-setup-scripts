Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
cinst -y docker-for-windows
cinst -y vscode-docker
