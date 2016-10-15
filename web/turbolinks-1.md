# Turbolinks

[Turbolinks](https://github.com/turbolinks/turbolinks)

Turbolinks makes navigating your web application faster.

Get the performance benefits of a single-page application wihout the added complexity of a client-side JavaScript framework.
client-side의 JavaScript 프레임워크의 복잡성을 추가하지 않고도 single-page application에서 성능 이득이 있음.

Use HTML to render your views on the server side and link to pages as usual.
평소하던 대로 server side에서 렌더링하고 링크.

When you follow a link, Turbolinks automatically fetches the page, swaps in its `<body>`, and merges its `<head>`, all without incurring the cost of a full page load.
link로 들어올 때 , Turbolinks는 자동으로 페이지를 fetch하고 `<body>`에 swap하며, `<head>`에 merge함, 전체 페이지를 로드할 때의 비용을 침해하지 않는 범위 내에서.

### Features

- **Optimizes navigation automatically.** No need to annotate links or specify which parts of the page should change.
- **No server-size coopertation necessay.** Respond with full HTML pages, not partial page fragments or JSON.
- **Respects the web.** The Back and Reload buttons work just as you'd expect. Search engine-friendly by design.
- **Supports mobile apps.** Adapters for iOS and Android let you build hybrid applications using native navigation controls.

### Supported Browsers

(skip)

### Installation

(skip)

## Navigating with Turbolinks

Turbolinks intercepts all clicks on `<a href>` links to the same domain.

When you click an eligible link, Turbolinks prevents the browser from following it.

Instead, Turbolinks changes the browser's URL using the History API, requests the new page using `XMLHttpRequest`, and then renders the HTML response.
대신, Turbolinks는 History API를 사용해서 브라우저 URL을 바꾸고, `XMLHttpRequest`로 새로운 페이지를 요청, 그리고 HTML response를  render.

During rendering, Turbolinks replaces the current `<body>` element outright and merges the contents of the `<head>` element.

The JavaScript `window` and `document` objects, and the HTML `<html>` element, persist from one rendering to the next.
JavaScriptㅇ `window`와 `document` object 그리고 HTML의 `html` element는 렌더링부터 다음까지 유지된다.

### Each Navigation is a Visit
Turbolinks models navigation as a *visit* to a *location* (URL) with an *action*.

Visits represent the entire navigation lifecycle from click to render.

That includes changing browser history, issuing the network request, restoring a copy of the page from cache, rendering the final response, and updating the scroll position.

browser history 바꿈, network request를 발생, cache된 페이지를 복사해서 저장, 최종 결과물을 렌더링, 그리고 scroll position을 업데이트.

There are two types of visit: an *application* *visit*, which has an action of *advance* or *replace*, and a *restoration* *visit*, which has an action of *restore*.

visit에는 두 가지 타입
- application visit : *advance* / *replace* action
- restoration visit : *restore* action

### Application Visits

Application visits are initiated by clicking a Turbolinks-enabled link, or programmatically by calling `Turbolinks.visit(location)`.

An application visit always issues a network request.
application visit은 항상 network request를 발생한다.

When the response arrives, Turbolinks renders its HTML and completes the visit.

If possible, Turbolinks will render a preview of the page from cache immediately after the visit starts.
만약 가능하다면, Turbolinks는 visit이 시작된 후 즉시 cache에 있는 페이지의 preview를 render할 것이다.

This improves the perceived speed of frequent navigation between the same pages.

If the visit's location includes an anchor, Turbolinks will attempt to scroll to the anchored element.

Otherwise, it will scroll to the top of the page.

Application visits result in a change to the browser's history; the visit's *action* determines how.

-- 그림 --

The default visit action is *advance*.

During an advance visit, Turbolinks pushes a new entry onto the browser's history stack using `history.pushState`.

Applications using the Turbolinks iOS adapter typically handle advance visits by pushing a new view controller onto the navigation stack.

Similarily, applications using the Android adapter typically push a new activity onto the back stack.

-- 그림 --

You may wish to visit a location without pushing a new history entry onto the stack.

The *replace* visit action uses `history.replaceState` to discard the topmost history entry and replace it with the new location.

새로운 history entry를 구성하고 싶을 때는 replace visit.

To specify that following a link should trigger a replace visit, annotae the link with `data-turbolinks-action="replace"`:

> <a href="/edit" data-turbolinks-action="replace">Edit</a>

To programmatically visit a location with the replace action, pass the `action: "replace"` option to `Turbolink.visit`:

> Turbolinks.visit("/edit", { action: "replace" })

### Restoration Visits

Turbolinks automatically initiates a restoration visit when you navigate with the browser's Back or Forward buttons.

Applications using the iOS or Android adapters initiate a restoration visit when moving backward in the navigation stack.

-- 그림 --

If possible, Turbolinks will render a copy of the page from cache without making a request.
Otherwise, it will retrieve a fresh copy of the page over the network.
See [Understanding Caching](https://github.com/turbolinks/turbolinks#understanding-caching) for more details.

Turbolinks saves the scroll position of each page before navigating away and automatically returns to this saved position on restoration visits.

Restoration visits have an action of *restore* and Turbolinks reserves them for internal use.

You should not attempt to annotate links or invoke Turbolinsk.visit with an action of `restore`.

### Canceling Visits Before They Start

Application visits can be canceled before they start, regardless of whether they were initiated by a link click or a call to `Turbolinks.visit`.

Listen for the `turbolinks:before-visit` event to be notified when a visit is about to start, and use `event.data.url` (or `$event.originalEvent.data.url`, when using jQuery) to check the visit's location.

Then cancel the visit by calling `event.preventDefault()`.

Restoration visits cannot be canceled and do not fire `turbolinks:before-visit`.

Turbolinsk issues restoration visits in response to history navigation that has *already taken place*, typically via the browser's Back or Forward buttons.

### Disabling Turbolinks on Specific Links

Turbolinks can be disabled on a per-link basis by annotating a link or any of its ancestors with `data-turbolinks="false"`.

```html
<a href="/" data-turbolinks="false">Disabled</a>

<div data-turbolinks="false">
  <a href="/">Disabled</a>
</div>
```

To reenable when an ancestor has opted out, use `data-turbolinks="true"`:

```html
<div data-turbolinks="false">
  <a href="/" data-turbolinks="true">Enabled</a>
</div>
```

Links with Turbolinks disabled will be handled normally by the browser.

