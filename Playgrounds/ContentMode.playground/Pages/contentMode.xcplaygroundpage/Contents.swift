/*:
 ### UIView contentMode Quick Guide
 
The `contentMode` property of UIView allows you to control how to layout a view when the view's bounds change. The system will not, by default, redraw a view each time the bounds change. That would be wasteful. Instead, depending on the content mode, it can scale, stretch or pin the contents to a fixed position.
 
 There are thirteen different content modes but it is easiest to think of three main groups based on the effect:
 
 #### Scaling the View (with or without maintaining the aspect ratio)
 
+ [Scale To Fill](ScaleToFill)
+ [Scale Aspect Fit](ScaleAspectFit)
+ [Scale Aspect Fill](ScaleAspectFill)
 
 #### Redrawing the View

+ [Redraw](Redraw)
 
 #### Positioning the View

+ [Center](Center)
+ [Top](Top)
+ [Bottom](Bottom)
+ [Left](Left)
+ [Right](Right)
+ [TopLeft](TopLeft)
+ [TopRight](TopRight)
+ [BottomLeft](BottomLeft)
+ [BottomRight](BottomRight)
*/
