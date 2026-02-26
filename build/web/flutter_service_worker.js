'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c5cdfbd6bc4c2749df06d5c07056d491",
"assets/AssetManifest.bin.json": "f32f2d76448af00439e4da2aaaf2a769",
"assets/assets/angular.png": "3ed91427828c7b282e4926da2423b8d6",
"assets/assets/Brochure/Company/Brochure.pdf": "5daaf7507daad629a46b27458eca4503",
"assets/assets/compress/14-min.jpeg": "fb378684d619d1162c3385090914c94e",
"assets/assets/compress/16-min.jpeg": "75c8ef979c25c384bdd0e6f26e2278c7",
"assets/assets/compress/18-min.jpeg": "53a895429c4a36add83d3bd7f62f90d7",
"assets/assets/compress/2-min.jpeg": "b9d971d056e473a965e1854321804e09",
"assets/assets/compress/37-min.jpeg": "8318f38351d444c8eabf87f5590d8aab",
"assets/assets/compress/5-min.jpeg": "ed92538a6ba96c92f93798cd6b0bc32b",
"assets/assets/compress/69-min_11zon.png": "74b99c3c7a251183cdbfad3eba216e89",
"assets/assets/compress/70-min_11zon.png": "66e15e30ede1ebb1064f622522bdae5f",
"assets/assets/compress/75-min.jpeg": "fc3e56108ab86bfbb809a7717eb60cbd",
"assets/assets/compress/77-min.jpeg": "35a8070a58173c19f0f2381bb74cffc7",
"assets/assets/compress/79-min.jpeg": "2dfb68e451eb8edc73162c8eabd4091e",
"assets/assets/compress/9-min.jpeg": "eacea06223768aaaf9e9eafd2c636828",
"assets/assets/compress/DSC_2507-min.jpeg": "f556679b5170672481964c14c4535547",
"assets/assets/compress/DSC_2507-min.webp": "4f39b50fea8f44185fdc09a8acf146b0",
"assets/assets/compress/DSC_2513-min.jpeg": "7939c92d63c71adef0348e791344f9d1",
"assets/assets/compress/DSC_2521-min.jpeg": "17e0a5241595d10a56d8865b3ff1d4c4",
"assets/assets/compress/DSC_2535-min.jpeg": "a2d8027871bcf8e5744d2e9233d9dd65",
"assets/assets/compress/DSC_2538-min.jpeg": "fafb744449869607dec39bc49f8f57bb",
"assets/assets/compress/DSC_2543-min.jpeg": "d8ae61b089d8451f36c64cafe4ff05c8",
"assets/assets/compress/DSC_2543-min.webp": "04f26db392b62e19a9cb4eb4e4ac57db",
"assets/assets/compress/DSC_2547-min.jpeg": "951681e9b4889da28363b03abf58734c",
"assets/assets/compress/DSC_2561-min.jpeg": "ed2ddd22db05b9a7847786de8d2d899e",
"assets/assets/compress/DSC_2566-min.jpeg": "e3f1fa993c883ebbf35bba6406e0943d",
"assets/assets/compress/DSC_2566-min.webp": "9a122b2037311bb07b7000e61b3fa4a1",
"assets/assets/compress/DSC_2578-min.jpeg": "9f2aa57ff862b0b3359672bb14d461bc",
"assets/assets/compress/DSC_2578-min.webp": "846db90226f1e4477ee03c871e532b12",
"assets/assets/compress/DSC_2584-min.jpeg": "0410b11640fe9f2645fd68138069476d",
"assets/assets/compress/DSC_2593.jpeg": "612983876edf1d547276c8225159fee4",
"assets/assets/compress/g01.jpeg": "0998edbf44051b833c8a35cec3edde64",
"assets/assets/compress/g02.jpeg": "950aec9c92edcaf6e4856a28d4771f5e",
"assets/assets/compress/g03.jpeg": "a47f6e9347a5efbdc395a8547ee87901",
"assets/assets/compress/g04.jpeg": "95341f097df26eadb12d986bfe0c4c57",
"assets/assets/dotNET.png": "8dc00d34d2ddd8602a0ccb4c8405e906",
"assets/assets/drcv.pdf": "33f7c7bdbd9707c55772bd8174f8c3fb",
"assets/assets/Express.png": "da2567a73dfe0c265b05aec9259d00b2",
"assets/assets/Home_Page/Core_Section/analysis.png": "cbac4db94e61e4f25c82bfc82f29f9ed",
"assets/assets/Home_Page/Core_Section/cyber.png": "4393bd4d4fc2cc089fffd267178d5165",
"assets/assets/Home_Page/Core_Section/develop.png": "64d2e4ed73cf7d45905e686502cebeb2",
"assets/assets/Home_Page/Core_Section/support.png": "ab80ecb144101c2b0e0b007c097f452a",
"assets/assets/Home_Page/Core_Section/testing.png": "830a41c6759d57a3917a35e1a3a0ab88",
"assets/assets/Home_Page/Core_Section/warehousing.png": "f1f15b0755d1c500f00356f48e43ad69",
"assets/assets/Home_Page/Website_Header/1.png": "575e2ca16c0599de9f179c53bc19d200",
"assets/assets/Home_Page/Website_Header/Header.png": "8b8b3cc16aa8a50dc560e8c86643c8b9",
"assets/assets/ic_launcher.jpg": "53d5d3ebfc07b4c90567f9f9033bb1e6",
"assets/assets/Logo/Company/ramchin.png": "106422390acfddff7553a419b1fb181f",
"assets/assets/Logo/Company/ramchinlogo.png": "28bfd6bd76b4c26ac348d6c93a0f3399",
"assets/assets/Logo/Company/ramchin_white.png": "d78b545a929e842b48ea9304cd4d30dd",
"assets/assets/Logo/Product/grocerymanagement.png": "c9bb00af0f3235d76b2357f81111339d",
"assets/assets/Logo/Product/hallmanagement.png": "25f1d24781d6adc023d25b3cd862a343",
"assets/assets/Logo/Product/hospitalmanagement.png": "c02a9644f5db3366b479ded84be5b592",
"assets/assets/Logo/Product/lodgemanagement.png": "9a105dfdd03ecd617690f8d47767286e",
"assets/assets/Logo/Product/moneymanagement.png": "45fe024e295a5e645f364461d6f862b9",
"assets/assets/Logo/Product/pharmacymanagement.png": "8fb71b691c3f172702308b00ff7426f2",
"assets/assets/Logo/Product/schoolmanagement.png": "96b645a4c4a082da97a41ad4b693334c",
"assets/assets/mong.png": "797cb351b1b34e7541883f57cb1c89e8",
"assets/assets/mongodb.png": "310f1c87c763727d098f093bcc969a5d",
"assets/assets/mysql2.png": "d8e78a7d055e0097df74ff185c1a2078",
"assets/assets/mysql21.png": "30ea64f9aa8ca1d386bda903ec48b4b3",
"assets/assets/nextjs.png": "8ab094bf98ea172461c99d151de01793",
"assets/assets/node.png": "9a1814348ebc9603894b4f9eb5fbf28f",
"assets/assets/node1.png": "a888e3fbc1c98a140fdd97c3d6052dec",
"assets/assets/OIP.png": "74094f4dafda6d121aa370ada2fc5627",
"assets/assets/php.png": "33c6dd30823ec4bf789518e65bec2e8c",
"assets/assets/png/14.jpeg": "b61fd04f73fa3b055fa5c8e43f14688b",
"assets/assets/png/16.jpeg": "d1de8de7873b3c43c2a8bc73d3cc4b97",
"assets/assets/png/18.jpeg": "8dc0239aa7b861de45d250442398552b",
"assets/assets/png/2.jpeg": "8fff5ab5ccb8bb03e87433e29166fc30",
"assets/assets/png/37.jpeg": "e6f3e1cafa897090cd8568367f9a5244",
"assets/assets/png/5.jpeg": "6532cacccb99b0e4e2cef8075bb1416b",
"assets/assets/png/75.jpeg": "2a1fd083c344bdbc94dcdcb27d927604",
"assets/assets/png/77.jpeg": "d7a8a62b89744209b2820a5b19b591ca",
"assets/assets/png/79.jpeg": "d8c1a1e6fcbd5425e88f9f1834150021",
"assets/assets/png/9.jpeg": "1ed908b2f82d8f598da2da09d595e42b",
"assets/assets/png/DSC_2507.jpeg": "97f2455ca3ec6796b0c35ddbf451051c",
"assets/assets/png/DSC_2513.jpeg": "dbb1c609d23e140c2b3aba5b38812de2",
"assets/assets/png/DSC_2521.jpeg": "339bf085afbd2f9aa897766391f4630e",
"assets/assets/png/DSC_2535.jpeg": "655b099829bf2507bf56e6f45efa44d1",
"assets/assets/png/DSC_2538.jpeg": "b3a0ba246764db8305da9f573218ea18",
"assets/assets/png/DSC_2543.jpeg": "55e771af1bd85559759b46e9cfa01ff6",
"assets/assets/png/DSC_2547.jpeg": "594c4f26a630c3294fe85f0643e645c9",
"assets/assets/png/DSC_2561.jpeg": "87c98fa28b1478b51488e769dc315c72",
"assets/assets/png/DSC_2566.jpeg": "0aacfae1e2acd5a3a797e3243d6840be",
"assets/assets/png/DSC_2578.jpeg": "ca25dc688a85aa758a379c8c6287e593",
"assets/assets/png/DSC_2584.jpeg": "67f6078f1b03b7eab504d311e2c8bbfe",
"assets/assets/png/DSC_2593.jpeg": "612983876edf1d547276c8225159fee4",
"assets/assets/png/g03.jpeg": "a47f6e9347a5efbdc395a8547ee87901",
"assets/assets/png/g04.jpeg": "95341f097df26eadb12d986bfe0c4c57",
"assets/assets/png/screen3.png": "c6401c794d765065ad023c6a60e56b0b",
"assets/assets/product/icon/photo-1522071820081-009f0129c71c.avif": "a7b76860fcb9afa3ae48f74351e3cb77",
"assets/assets/product/icon/playstore.png": "f88c8631a004770b9d03d261891fb379",
"assets/assets/product/logo/grocerymanagement.png": "c9bb00af0f3235d76b2357f81111339d",
"assets/assets/product/logo/hallmanagement.png": "25f1d24781d6adc023d25b3cd862a343",
"assets/assets/product/logo/hospitalmanagement.png": "c02a9644f5db3366b479ded84be5b592",
"assets/assets/product/logo/lodgemanagement.png": "9a105dfdd03ecd617690f8d47767286e",
"assets/assets/product/logo/moneymanagement.png": "45fe024e295a5e645f364461d6f862b9",
"assets/assets/product/logo/pharmacymanagement.png": "8fb71b691c3f172702308b00ff7426f2",
"assets/assets/product/logo/schoolmanagement.png": "96b645a4c4a082da97a41ad4b693334c",
"assets/assets/Profile/Interns/Brightlin.jpeg": "a4bec11e06789054e2a6abcad692b758",
"assets/assets/Profile/Interns/Dharsha.jpeg": "3bddb3ef3850a9e8b49ba2f1f11b300f",
"assets/assets/Profile/Interns/Essakkiyammal.jpg": "f37b82b06951a3a5364ab321a30dc39f",
"assets/assets/Profile/Interns/Lakshmi.jpeg": "6ec3787d2877cb8cc199b1f81224c174",
"assets/assets/Profile/Interns/MuraliKumar.jpeg": "5c24a87a7ed888011a6246eafb11933a",
"assets/assets/Profile/Interns/Pooja.jpg": "97db32a8c620a721e0dc8ae935c658a6",
"assets/assets/Profile/Interns/RajaGopika.jpeg": "f112f945be7d9bc1a4139a8c33abc34f",
"assets/assets/Profile/Interns/Ramu.jpeg": "63e839d82889d9be736ca4c85e8936b8",
"assets/assets/Profile/Interns/Sowmiya.jpeg": "1ce0272b90aff0db00a666f47162d917",
"assets/assets/Profile/Interns/SwarlinAishwarya.jpeg": "48d9ff7f54d24b544c30660751adb629",
"assets/assets/Profile/Interns/Yogalakshmi.jpeg": "b525f4108fd5229aca67014f2594a0a1",
"assets/assets/Profile/Management_Member/CEO.jpg": "2f295ca41a7fd668a915a6124e22f74b",
"assets/assets/Profile/Management_Member/Director-Admin.jpeg": "8814a094732597806a2aab7ec61d42b5",
"assets/assets/Profile/Management_Member/Director-Operation.png": "a262a5a6c34cca28a3e420724697e4eb",
"assets/assets/Profile/Management_Member/HRD.png": "61a42850fa7ec039d88c4b186bb05726",
"assets/assets/Profile/Software_Developer/Balasubramanian.jpeg": "5e30f1f93c22e533b5aa5b3b51b5a313",
"assets/assets/Profile/Software_Developer/Parthiban.jpg": "c474ac35af9417374375f683d7adc208",
"assets/assets/Profile/Software_Developer/ShivaniShree.jpeg": "2acbb451de72c74ae87f00879759b5cc",
"assets/assets/react.png": "b7c0a91cec1611d45d2be27bb2883cc1",
"assets/assets/react1.png": "63dbda326acdcbb06bced8c346f257d9",
"assets/assets/screen1.png": "85e01eef5fb7ddd8b879b648f568b08b",
"assets/assets/screen2.png": "42b9028af04653a3b9943b35c0ce3fd4",
"assets/assets/screen3.png": "c6401c794d765065ad023c6a60e56b0b",
"assets/assets/screenV.mp4": "f56f01720919d881dda7391f3bc65f26",
"assets/assets/ss30.jpg": "127dd8f41e37a6c9543e3329ad81a44f",
"assets/FontManifest.json": "b2f3c0711a99a3f0a6b1c09801148d72",
"assets/fonts/MaterialIcons-Regular.otf": "75cefc06b324c75563d6f4ad841c3316",
"assets/NOTICES": "da1dda71118230041d705f0b74bfd13f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "290ffc3e187d2ee7668018ec1be2d53d",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "7ebca738c8e8b21b26d81c72a8b581de",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "f50a7961b7aa88db17ffad56159b44b1",
"assets/packages/simple_icons/fonts/SimpleIcons.ttf": "b4422d8961ad968735c9b2c7662dcf38",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "b28c9a93f2741ffc2171cfcf81c02b9b",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "0995c72f1b462e641bea096c555e2f9a",
"icons/Icon-192.png": "eeea019b352e20cd488c177a2d7ca46b",
"icons/Icon-512.png": "eeea019b352e20cd488c177a2d7ca46b",
"icons/Icon-maskable-192.png": "eeea019b352e20cd488c177a2d7ca46b",
"icons/Icon-maskable-512.png": "eeea019b352e20cd488c177a2d7ca46b",
"index.html": "9e2323c4944e7a8c4291a1984c972d46",
"/": "9e2323c4944e7a8c4291a1984c972d46",
"main.dart.js": "f57a9ff3bcacf654398b42007e1ce2f8",
"manifest.json": "292c8624068e27110bcc3bae96fd145d",
"preview.png": "eeea019b352e20cd488c177a2d7ca46b",
"version.json": "b9dfb0e2f37ff72c1204f7dd189959c0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
