# meals

A new Flutter project.

## 18/09/25 What i learnt

This lesson was about tab management, how to create a multi screen app and share data across each page while maintaining reasonable architectural design and consistent functionality.

1. Scaffold Widget is your go to if you gonna create a page. AppBar, Body, Bottom Nav (if you wanna make tabs), Drawer is also available for you.
2. When navigating from a page and want some data on the page to be exposed to other pages, use the PopScope widget. inside it, make the Navigator.pop({data}); if there is a drawer involved, close that drawer first, call the widget whose data you intend to receive with a return, (use async-await) 
   
   ```
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

   ```
3. Inkwell vs Gesture Detector: 👉 Rule of thumb:
	•	Use InkWell (or InkResponse) when you want a button-like effect with ripple feedback.
	•	Use GestureDetector when you need raw gesture handling (swipes, drags, scales, multi-touch) or don’t want Material UI tied in.
4. Use FadeInImage and Network image to load images from urls in a cool way:
     transparent_image: ^2.0.1

   ```
   FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
   
   ```

   ## NOW LEARNING RIVERPOD FOR BETTER STATE MANAGEMENT
   
