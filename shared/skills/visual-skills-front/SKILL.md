---
name: visual-skills-front
description: Add and use Lenis, GSAP, Vanta, or React Bits in an existing website when the user asks for smooth scrolling, scroll animation, an animated background, or a React visual effect.
---

# Visual skills for frontend projects

This skill guides project-level use of four JavaScript libraries. It is not a global library installer. Add only the library and effect needed for the user's request; check the project's framework, package manager, existing dependencies, visual style, and motion behavior first. Use the current official documentation linked below because APIs and install commands can change.

## Choose the tool

| Goal | Tool |
| --- | --- |
| Smooth page scrolling | Lenis |
| Sequenced or scroll-driven animation | GSAP; add ScrollTrigger only for scroll-driven work |
| Animated WebGL background | Vanta |
| Ready-made visual component in a React site | React Bits |

If the request is vague, prefer the smallest effect that serves the page. Do not add a motion library when CSS or an existing dependency already solves the task. React Bits requires React; do not convert a non-React project just to use it.

## Install and use

The commands below use npm as examples. Use the package manager already present in the project, and skip packages already installed. Make changes inside the website project, never globally on the Mac.

### Lenis — smooth scroll

- **Install:** `npm install lenis`. Import `lenis/dist/lenis.css`. For React, use the `lenis/react` adapter when it fits the existing app.
- **Use:** Create one Lenis instance for the page or scroll container. In a plain JavaScript app, `new Lenis({ autoRaf: true })` is the basic setup. If the project owns its animation loop, call `lenis.raf(time)` there instead of starting a second loop. Clean up with `lenis.destroy()` when the owning view ends.
- **Check:** Anchor links, browser history, nested scroll areas, menus, dialogs, touch scrolling, and `prefers-reduced-motion`. Keep native scrolling where smoothing causes a usability problem. For GSAP ScrollTrigger, synchronize Lenis scroll events and the GSAP ticker using the current official example.
- **Source:** [Lenis README](https://github.com/darkroomengineering/lenis) and [React adapter](https://github.com/darkroomengineering/lenis/blob/main/packages/react/README.md).

### GSAP — targeted animation

- **Install:** `npm install gsap`. Import `gsap` and only the plugins needed, such as `ScrollTrigger` from `gsap/ScrollTrigger`; register imported plugins with `gsap.registerPlugin(...)`.
- **Use:** Animate the requested elements with a scoped timeline or tween. For scroll effects, attach a ScrollTrigger to the relevant element. In React, use a component-scoped GSAP context or the current official React integration and revert it on unmount. Keep text and controls visible if JavaScript fails.
- **Check:** Animation timing, repeated mounts, resize behavior, mobile layout, and `prefers-reduced-motion`. If Lenis already controls scrolling, use one synchronized loop rather than competing controllers.
- **Source:** [GSAP installation](https://gsap.com/docs/v3/Installation/) and [ScrollTrigger](https://gsap.com/docs/v3/Plugins/ScrollTrigger/).

### Vanta — animated background

- **Install:** `npm install vanta` and the renderer required by the selected effect: `three` for three.js effects or `p5` for p5.js effects. Verify compatible versions in the current documentation before installing.
- **Use:** Import only the chosen effect, such as `vanta/dist/vanta.birds.min`. Initialize it after the target element exists, passing that element as `el` and the selected renderer as `THREE` or `p5`. Store the returned instance and call `.destroy()` when the view unmounts or the effect changes. Initialize on the client in server-rendered frameworks.
- **Check:** Readable text and clickable controls over the background, mobile performance, navigation cleanup, and a static fallback for reduced motion, missing WebGL support, or initialization failure.
- **Source:** [Vanta README](https://github.com/tengbao/vanta).

### React Bits — one React component

- **Install:** Confirm the project uses React. Pick a component and its JS/TS and CSS/Tailwind variant from the [official collection](https://www.reactbits.dev/) or [repository](https://github.com/DavidHDev/react-bits). Follow that component page's current copy or CLI command; for a project already using shadcn, an example is `npx shadcn@latest add @react-bits/BlurText-TS-TW`. Add only that component and its listed dependencies.
- **Use:** Import the generated component from its actual project path and render it in the requested place. Adjust its props and styles to match the site. Do not copy the full collection or add an unrelated effect just because it is available.
- **Check:** React compatibility, responsive layout, readable fallback content, `prefers-reduced-motion`, and cleanup for any animation or event listeners used by the chosen component.

## Finish the project task

Run the project's relevant build or checks and inspect the result at desktop and mobile sizes. Report which library and effect were used, what was installed, and what was verified. Do not publish the website unless the user asks.

To invoke this skill explicitly, the user can ask: `Χρησιμοποίησε το $visual-skills-front για να προσθέσεις Lenis/GSAP/Vanta/React Bits στο website project μου.`
