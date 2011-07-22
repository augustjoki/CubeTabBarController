CubeTabBarController
====================

The normal switching between view controllers on UITabBarControllers is boring. No animation whatsoever. So I decided to add a cube animation. It uses CoreAnimation to be able to rotate around the Y-axis (the one pointing out of the top of the phone). I had to use CATransformLayer to preserve the 90° angle while keeping the edges of the views touching.

I actually started with using iOS 5's container api and got it working with that, but then tried to see whether I could get it to work with a subclass of UITabBarController.

![Mid rotation](http://cl.ly/8ebt)

NOTE: This project is built with ARC if you need to use it with MRR you'll have to add all the proper methods.