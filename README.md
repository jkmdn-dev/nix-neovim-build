# [Neovim](https://github.com/neovim/neovim/) built with Nix

### Why?
I recently switched to [NixOS](https://nixos.org/) and I tried to port all my Neovim configurations. I hadn't realized that some of the stuff I did in those depended on a recent dev build (I think, still not sure about that). I had fun trying some stuff with Neovim, so I guess I ended up with a random commit on the master branch installed on the system. Anyway, my init.lua (yes - only one file - no you may not see it - I'm not embarrassed about it, I promise!) didn't work, due to some lpeg stuff I used. I couldn't find a package that was not more up-to-date. I also didn't want to just clone the repo and build it like I did before, I wanted the Nix experience. I got the Nix experience, and here we are.

### Future of this repo?
I don't know, I'm not sure anyone other than me want something like this. Suggestions wanted!

### Disclaimer
The build system of Neovim is very good and easy to follow, that's the only reason I could do this in a timely manner. I have some prior experience of migrating build systems, but this was very fun and a joy, due to an execellent build system! You don't know what kind of monstrosities people come up with (or maybe you do... just know, I know the pain...). Neovim is a beautiful project!
