# portfolio
My personal developer portfolio showcasing Flutter, .NET, Angular, and mobile application projects.

## Building for production

```
flutter build web --release --no-web-resources-cdn
```

The `--no-web-resources-cdn` flag is required. Without it, Flutter fetches the CanvasKit
renderer (~2MB) from Google's `gstatic.com` CDN at runtime on every visitor's first load —
an external dependency outside our control that fails the whole app (blank screen) if that
CDN is slow, blocked, or down in the visitor's region. With the flag, CanvasKit is bundled
into `build/web/canvaskit/` and served from the same host as everything else, so it rides
whatever CDN/caching the deploy target already provides for the rest of the site.
