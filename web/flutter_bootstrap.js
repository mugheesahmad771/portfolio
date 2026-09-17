{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    // The engine is ready to paint — hand off from the static HTML
    // splash/SEO content (index.html) to the real app now, not before.
    const splash = document.getElementById('app-splash');
    if (splash) splash.remove();

    await appRunner.runApp();
  },
});
