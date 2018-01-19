## WorldFacts

The WorldFacts App has gone through a number of iterations over the
years as the capabilities of iOS have changed. Originally it started
as an example of how to construct custom table view cells with a
storyboard. Some of the earlier posts are likely only of historical interest
now but I think it is interesting to show how much iOS apps need to change
over the years.

For further details see the following posts:

* [Prototype Table Cells and Storyboards](https://useyourloaf.com/blog/prototype-table-cells-and-storyboards/)

For details on adding a storyboard segue to show the country detailed
view see the following post:

* [Storyboard Segues](https://useyourloaf.com/blog/storyboard-segues/)

The steps to add a search bar to the table view controller are covered
in the following post:

* [Adding A Search Bar To A Table View With Storyboards](https://useyourloaf.com/blog/search-bar-table-view-storyboard/)

The release of iOS 8 saw a number of changes to update and modernise
the code:

+ UISearchDisplayController is deprecated and replaced by the much
  cleaner UISearchController
+ Modules are now used instead of precompiled headers
+ The Storyboard is now universal
+ Include a launch screen storyboard
+ Autolayout is used
+ Dynamic Type is used for the content
+ Asset Catalogs for the icons and images
+ Base Internationalization
+ Remove old orientation handling code.

An OS X companion app has also been added to create and maintain the core
data stack. Full details on how to use Cocoa Bindings to create a simple
interface to Core Data are covered in the following post:

* [Creating an OS X Core Data Helper App](https://useyourloaf.com/blog/creating-an-os-x-core-data-helper-app/)

To see details on how to increase the width of the master view of the split
view controller see the following post:

* [Change the Width of Master View in Split View Controller](https://useyourloaf.com//blog/change-the-width-of-master-view-in-split-view-controller/)

The geographic data used in this App is from GeoNames and used under
the Creative Commons Attributions License. See [www.geonames.org](www.geonames.org).


### Model

* `WorldFacts.xcdatamodeld`

    The core data model definition contains a single entity for the Country
managed object.

* `Country.h`
* `Country.m`

    The generated `NSManagedObject` subclass

* `Country+Extensions.h`
* `Country+Extensions.m`

    Private class extensions for the Country NSManagedObject subclass to
generate the section title used by the NSFetchedResultsController and
to import an initial set of geographic data from countries.plist.

### View

* `Main.storyboard`

    The universal storyboard file used to create the table and details view

### Controllers

* `UYLCountryTableViewController.h`
* `UYLCountryTableViewController.m`

    The table view controller used to show the list of countries with
details on the capital and population and manage the search interface.
The table view controller implementation is a standard implementation
of an `NSFetchResultsController`.

* `UYLCountryViewController.h`
* `UYLCountryViewController.m`

    The view controller used to show the detailed country view. This view
controller does almost nothing other than set up the view from the
Country object it is passed.

### App Delegate

* `UYLAppDelegate.h`
* `UYLAppDelegate.m`

    The App delegate is largely unmodified from the template code. It creates
the root view controller using a storyboard and initialises the core data
stack.

### Version History

Version 3.3 19 Jan  2018    Update for Xcode 9, minimum target is iOS 9
Version 3.2 12 Oct  2015    Add 3D Touch peek and pop preview
Version 3.1 25 May  2015    Increase width of split view master view
Version 3.0 27 Mar  2015    Add OS X application to create core data
Version 2.0 16 Feb  2014    Update for iOS 8 and UISearchController
Version 1.5 20 Feb  2013    Move core data file to App Support dir
Version 1.4 31 Dec  2012    Add default launch images to support retina
4 inch display
Version 1.3  6 Sep  2012    Add a search bar
Version 1.2  1 Aug  2012    Use default synthesis of ivars
Version 1.1 21 June 2012    Add Storyboard segue to country view
Version 1.0  6 June 2012    Initial Version

