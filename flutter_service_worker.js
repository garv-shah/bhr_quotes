'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"splash/style.css": "e6eb645a4789b964e333eeb15f69ba91",
"splash/img/light-4x.png": "399f0a048f83fa59a6ba5256ab3e1bac",
"splash/img/dark-2x.png": "50c48e59fa30fb379b20cd9cdc441b8f",
"splash/img/light-3x.png": "a930e30e3bdb05319ba15e529bd6dab8",
"splash/img/light-2x.png": "7a42d80260991726d52286d7b2f6f10e",
"splash/img/dark-4x.png": "93d6e9702a89112e29897b450508103a",
"splash/img/dark-1x.png": "59b8f0ceade0d299031d483b83bb5a5d",
"splash/img/dark-3x.png": "9ef0a6830b920697c5a6ce535b934e98",
"splash/img/light-1x.png": "7319ee24dc35435c6aa7ca5f587c51c5",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"index.html": "b8120d7c5ca34847140b4bf51d46387d",
"/": "b8120d7c5ca34847140b4bf51d46387d",
"mstile-310x310.png": "ca9bebb143b10836390c5918c0ec3073",
"favicon-16x16.png": "7b486f60dc44abbc5ba55372c89e9755",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"browserconfig.xml": "44e2252eba2215291293625543185ed7",
"favicon-32x32.png": "907538c08612e7f23b3a25323ba93548",
"mstile-70x70.png": "86dd67811ce1a1fb639154f414707948",
"favicon.png": "ed56d8ad324338a0fc956e014fb0ed68",
"mstile-150x150.png": "98dd54a464642956ae68649e416b73f9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "dcca82492231098637e3aac310944984",
"assets/AssetManifest.bin.json": "654e438507194c14513fb118d2bd64eb",
"assets/assets/foreground_icon.png": "adc9bac01b5fec47ed60c8fe01c79f2f",
"assets/assets/full_icon.png": "af7afa4b6da36ce70a66bde1c0b25fd3",
"assets/assets/app_icon.svg": "1ef102d6adb01e56bf040d3a0df8a436",
"assets/assets/app_icon.png": "06f3f7b7f39ac88f2ce579bc3d8ec18d",
"assets/AssetManifest.bin": "7545dec887bd394cc98fb3785a069649",
"assets/NOTICES": "5409b210c6e18be53323d1a28b5aed40",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "25ff823d86e2b533d14d59570c1afc28",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/AssetManifest.json": "205e09e7e2c2f27169707aa86e682e87",
"version.json": "9291ba0527513a2a1f66a5ac1a89d6d7",
"safari-pinned-tab.svg": "48837b54c65dae06b43bf80fadb189f6",
"favicon.ico": "233b28f2ae275ead424f5a38ed8db74b",
"manifest.json": "5f9f81ed744b80f742575f9b37526296",
"android-chrome-512x512.png": "f9b0e8f035384344bfd42b1c9f8d7324",
"apple-touch-icon.png": "2c57a35dc32a73c27ad5df2f6a5c8abc",
"android-chrome-192x192.png": "99352d661546120b2266cd2ec03f8dec",
"mstile-310x150.png": "8e6ad9c0ce2dbce5d3c9a2a73ad73e34",
"mstile-144x144.png": "e71a1c9453024266ccd7a8b2d72b4057",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"main.dart.js": "d2c5658adee7cc6b3df1bc5c9b3a804e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
