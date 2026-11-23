# Arcation Desktop

Windows 11 / Fluent desktop client prototype for Arcation, with:

- Arcation Home
- icon-only navigation
- Discover and Library
- Create / Let's Make an App wizard
- Arcation Studio
- live preview and pop-out player UI
- built-in AI panel UI

## Build the real MSIX on GitHub

This repository intentionally does **not** ship a hand-made `.msix`. GitHub Actions uses Microsoft's **MakeAppx.exe** from the Windows SDK to create the package, including the correct AppxBlockMap metadata.

1. Create a GitHub repository.
2. Upload this folder to the repository.
3. Push it to the `main` branch, or open **Actions → Build Arcation Desktop MSIX → Run workflow**.
4. When the workflow finishes, open the run and download the **ArcationDesktop-MSIX** artifact.
5. Extract the artifact ZIP to get `ArcationDesktop.msix`.

The package is unsigned, so Windows may require developer/unsigned-package installation steps. The important part is that the MSIX itself is produced by Microsoft's packaging tool rather than being assembled manually.

## Important

The AI panel is currently a UI/tool shell; a full local reasoning model is not bundled into this small repository. The Studio UI is structured so a local model/tool runner can be connected later.
