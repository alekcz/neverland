# neverland

*A magical for [Pixie](https://github.com/pixie-lang/pixie)*.

Provides web client connectivity tools for Pixie

## Usage


Add `neverland` as a dependecy using [dust](https://github.com/pixie-lang/dust)

[alekcz/neverland.pxi "0.0.1"]

```clojure
(ns foo.bar
  (require neverland.core :as nv))

(println (nv/get-ip "achielit.com"))

```
## Copying

Free use of this software is granted under the terms of the GNU Lesser General Public License (LGPL). For details see the files LICENSE included with the source distribution. All copyrights are owned by their respective authors.