

resolve-flatpak
===============

This is a fork from: https://github.com/pobthebuilder/resolve-flatpak.git

This repo allows you to package DaVinci Resolve as a Flatpak for use on Linux Flatpak
based systems. 

Usage
-----

1. If you have appimagelauncherd (the AppImage Launcher daemon) installed and enabled, you NEED to temporarely disable it (either through systemctl or through the AppImage Launcher GUI) as it conflicts with flatpak-builder during the .run file repackaging process.

2. Clone this repo with: `git clone https://github.com/vidalinux/resolve-flatpak.git`
By default, com.blackmagic.Resolve.yaml is configured to package the latest stable version of Resolve (18.1.4).

3. Build your package, and export to a distributable single file installer:

#### Free
```
flatpak-builder --force-clean --repo=repo build-dir com.blackmagic.Resolve.yaml
flatpak build-bundle repo resolve.flatpak com.blackmagic.Resolve
```
#### Studio
```
flatpak-builder --force-clean --repo=repo build-dir com.blackmagic.ResolveStudio.yaml
flatpak build-bundle repo resolve.flatpak com.blackmagic.ResolveStudio
```

4. Enjoy.

## Finding explicit Download IDs (for download-resolve.sh)
#### Studio:

```
curl -o- https://www.blackmagicdesign.com/api/support/nz/downloads.json |
    jq -r '.downloads[]
            | select(.urls["Linux"] != null)
            | select(.urls["Linux"][0]["product"] == "davinci-resolve-studio")
            | [.urls["Linux"][0].downloadTitle, .urls["Linux"][0].downloadId]
            | @tsv'
```

#### Free:

```
curl -o- https://www.blackmagicdesign.com/api/support/nz/downloads.json |
    jq -r '.downloads[]
            | select(.urls["Linux"] != null)
            | select(.urls["Linux"][0]["product"] == "davinci-resolve")
            | [.urls["Linux"][0].downloadTitle, .urls["Linux"][0].downloadId]
            | @tsv'
```

## Licensing
The icon in logo.png is licensed under the Creative [Commons Attribution-Share Alike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/deed.en) and fetched from [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:DaVinci_Resolve_Studio.png). It was only cropped afterwards.
