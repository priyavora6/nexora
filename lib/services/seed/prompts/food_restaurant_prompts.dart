// lib/services/seed/prompts/food_restaurant_prompts.dart

class FoodRestaurantPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Indian Cuisine':
        return [
          {
            'title': 'Luxury Biryani Ad',
            'platform': 'Midjourney',
            'description': 'Turn your home biryani into a 5-star ad',
            'text': 'Transform this photo of a biryani plate into a high-end restaurant advertisement. Add realistic steam rising, fresh saffron strands on top, and a side of creamy raita in a clay bowl. Use warm, moody lighting and a rustic wooden table background. Professional food photography style.',
          },
          {
            'title': 'The Royal Thali',
            'platform': 'Leonardo AI',
            'description': 'Upgrade a simple thali to a Maharaja feast',
            'text': 'Recreate this thali photo as a "Maharaja Grand Feast." Change all utensils to polished brass and silver. Add extra bowls of traditional curries, a stack of buttered naan, and a glass of lassi. Set the background to a luxury heritage hotel dining room. Highly detailed textures.',
          },
          {
            'title': 'Street Food Glow-up',
            'platform': 'DALL-E 3',
            'description': 'Make Pani-Puri look incredibly appetizing',
            'text': 'Take this photo of street food and transform it into a vibrant, clean, and professional food blog post. Focus on the crispiness of the puris and the splashing water. Add fresh coriander garnish and bright, sunny outdoor lighting. Eye-popping colors.',
          },
          {
            'title': 'Butter Chicken Masterpiece',
            'platform': 'Midjourney',
            'description': 'Focus on creamy textures and colors',
            'text': 'Modify this photo of a curry to look like a premium Butter Chicken dish. Add a swirl of fresh cream on top and a melting piece of butter. The sauce should look rich, thick, and velvety. Background should be a dark, elegant restaurant setting with soft bokeh.',
          },
          {
            'title': 'South Indian Morning',
            'platform': 'Stable Diffusion XL',
            'description': 'A fresh and bright Dosa/Idli shoot',
            'text': 'Transform this photo of a South Indian breakfast into a bright, airy morning scene. Place the Dosa on a fresh banana leaf. Add small steel bowls of colorful chutneys and steaming sambar. High-resolution textures, natural morning sunlight through a window.',
          },
          {
            'title': 'Tandoori Platter Smoke',
            'platform': 'Leonardo AI',
            'description': 'Add a sizzling charcoal effect',
            'text': 'Recreate this photo of kebabs as a sizzling tandoori platter. Add realistic charcoal smoke and charred edges to the meat. Place it on a cast-iron sizzler plate with grilled onions and lemons. Intense, dramatic lighting.',
          },
          {
            'title': 'Festive Mithai Box',
            'platform': 'Midjourney',
            'description': 'Turn your sweets into a Diwali gift ad',
            'text': 'Take the sweets from this photo and arrange them in a luxury gold-foiled gift box. Add rose petals and silver vark (leaf) on the sweets. The background should be festive with diyas and silk fabric. Commercial quality product photography.',
          },
          {
            'title': 'Home-cooked with Love',
            'platform': 'DALL-E 3',
            'description': 'A warm, aesthetic home-dining vibe',
            'text': 'Modify this home-cooked meal photo to look aesthetic and "Pinterest-worthy." Add a linen napkin, elegant cutlery, and a glass of water with lemon. Soft, natural lighting. The food should look healthy, fresh, and inviting.',
          },
          {
            'title': 'Spices of India Macro',
            'platform': 'Leonardo AI',
            'description': 'Focus on raw ingredients and textures',
            'text': 'Transform this photo of spices into a high-detail macro shot. Focus on the textures of cinnamon sticks, star anise, and red chilies. Add a dusting of turmeric powder in the air. Professional culinary art style, deep colors.',
          },
          {
            'title': 'Tea-Time Aesthetic',
            'platform': 'Flux AI',
            'description': 'Convert your tea/chai photo to a mood shot',
            'text': 'Take this photo of a cup of tea and turn it into a cozy "Chai-Time" moment. Add a plate of crispy pakoras, a newspaper, and rain droplets on a window in the background. Warm, nostalgic morning atmosphere. Realistic steam effect.',
          },
        ];

      case 'Fast Food':
        return [
          {
            'title': 'The Ultimate Burger Drip',
            'platform': 'Midjourney',
            'description': 'Turn your burger photo into a commercial',
            'text': 'Transform this burger photo into a professional fast-food advertisement. Add melting cheddar cheese dripping down the sides, crisp vibrant lettuce, and juicy tomato slices. Set against a dark, high-contrast background with dramatic spot lighting.',
          },
          {
            'title': 'Cheese-Pull Pizza',
            'platform': 'Leonardo AI',
            'description': 'Add an epic cheese stretch to your pizza',
            'text': 'Modify this pizza photo to show a slice being lifted with a long, gooey, realistic cheese pull. Add pepperoni slices that look crispy and glistening. The crust should look perfectly baked and flour-dusted. High-speed action food photography.',
          },
          {
            'title': 'Crispy Fried Chicken',
            'platform': 'DALL-E 3',
            'description': 'Focus on the crunch and texture',
            'text': 'Recreate this photo of fried chicken to look incredibly crunchy. Every flake of the breading should be sharp and detailed. Add a side of dipping sauce with a splash effect. Bright, energetic commercial lighting.',
          },
          {
            'title': 'Golden French Fries',
            'platform': 'Midjourney',
            'description': 'Make your fries look hot and salty',
            'text': 'Take this photo of fries and make them look fresh out of the fryer. Add visible salt crystals and a dusting of herbs. Background is a blurred fast-food restaurant at night. Focus on the golden-brown texture. 8k resolution.',
          },
          {
            'title': 'Taco Night Fiesta',
            'platform': 'Stable Diffusion XL',
            'description': 'A colorful and messy taco transformation',
            'text': 'Transform this photo into a vibrant Taco feast. Add fresh lime wedges, crumbles of cotija cheese, and vibrant purple cabbage. The background should be a colorful Mexican-style outdoor table. Sunny, high-contrast lighting.',
          },
          {
            'title': 'The Perfect Sandwich Cross-section',
            'platform': 'Leonardo AI',
            'description': 'Show the inside layers clearly',
            'text': 'Modify this sandwich photo into a perfect cross-section view. Every layer (meat, cheese, veggies) should be perfectly aligned and fresh. Use a macro lens effect to show the texture of the bread. Clean white marble background.',
          },
          {
            'title': 'Refreshing Soft Drink Splash',
            'platform': 'Midjourney',
            'description': 'Add ice and bubbles to your drink',
            'text': 'Take this photo of a glass and transform it into a refreshing cola ad. Add large clear ice cubes, condensation on the outside of the glass, and a dramatic splash of liquid with bubbles. Intense backlighting to make it glow.',
          },
          {
            'title': 'Hot Dog Gourmet Style',
            'platform': 'DALL-E 3',
            'description': 'Upgrade a simple hot dog photo',
            'text': 'Transform this hot dog into a gourmet version. Add caramelized onions, jalapeños, and a perfect zigzag of mustard and ketchup. Set the background to a trendy street-food market. Sharp focus, professional food styling.',
          },
          {
            'title': 'Wok-Fried Noodles',
            'platform': 'Midjourney',
            'description': 'Capture the action of Chinese food',
            'text': 'Recreate this noodle photo as a high-action wok fry. Add a flame effect in the background and noodles frozen in mid-air. Vibrant vegetables and glossy sauce. Cinematic kitchen lighting, motion blur.',
          },
          {
            'title': 'Donut Glaze Close-up',
            'platform': 'Flux AI',
            'description': 'Focus on the sweetness and toppings',
            'text': 'Transform this donut photo into a luxury bakery ad. The glaze should look thick and shiny. Add colorful sprinkles and a dusting of powdered sugar in the air. Soft pastel background, appetizing and sweet.',
          },
        ];

      case 'Desserts Sweets':
        return [
          {
            'title': 'Molten Choco Lava',
            'platform': 'Midjourney',
            'description': 'Capture the perfect chocolate center',
            'text': 'Transform this cake photo into a molten chocolate lava cake. Show the warm chocolate centers flowing out onto the plate. Add a scoop of vanilla bean ice cream on the side. Dark, elegant background with a dusting of cocoa powder.',
          },
          {
            'title': 'Traditional Mithai Platter',
            'platform': 'Leonardo AI',
            'description': 'Make Indian sweets look like jewels',
            'text': 'Modify this photo of sweets into a luxury Indian Mithai platter. Add silver leaf (vark) to the Kaju Katli and crushed pistachios to the Gulab Jamun. Use a gold-plated platter and silk fabric background. Warm, royal lighting.',
          },
          {
            'title': 'Ice Cream Sundae Tower',
            'platform': 'DALL-E 3',
            'description': 'A fun and colorful dessert makeover',
            'text': 'Recreate this photo as a massive, colorful ice cream sundae. Add layers of chocolate sauce, whipped cream, cherries, and colorful wafers. The ice cream should look cold with visible frost. Bright, cheerful party lighting.',
          },
          {
            'title': 'French Macaron Tower',
            'platform': 'Midjourney',
            'description': 'A high-end pastry shop aesthetic',
            'text': 'Take the macarons from this photo and arrange them in a perfect pastel tower. The background should be a luxury Parisian patisserie. Soft, flattering lighting. Focus on the smooth shells and creamy filling.',
          },
          {
            'title': 'Red Velvet Slice',
            'platform': 'Stable Diffusion XL',
            'description': 'Focus on the velvet cake texture',
            'text': 'Transform this cake slice photo into a premium Red Velvet cake ad. The cake should look incredibly soft and "velvety." Add thick, smooth cream cheese frosting layers. Set the background to a minimalist white cafe. Clean and sharp.',
          },
          {
            'title': 'Fruit Tart Freshness',
            'platform': 'Leonardo AI',
            'description': 'Add vibrant fruits to your dessert',
            'text': 'Modify this photo to show a fruit tart topped with glistening glazed strawberries, blueberries, and kiwi. The crust should look buttery and crumbly. Bright, natural sunlight. High-quality bakery photography.',
          },
          {
            'title': 'Cheesecake Berry Drip',
            'platform': 'Midjourney',
            'description': 'Add a delicious sauce effect',
            'text': 'Take this cheesecake photo and add a thick, vibrant strawberry sauce dripping down the side. The texture of the cheesecake should look creamy and dense. Use a shallow depth of field with a blurred kitchen background.',
          },
          {
            'title': 'Waffle Breakfast Feast',
            'platform': 'DALL-E 3',
            'description': 'A warm and inviting morning dessert',
            'text': 'Recreate this photo as a luxury waffle breakfast. Add a dollop of butter melting on hot waffles, maple syrup being poured, and fresh berries. Morning sun rays through a window. Warm, cozy, and delicious.',
          },
          {
            'title': 'Traditional Kulfi Stick',
            'platform': 'Leonardo AI',
            'description': 'A nostalgic Indian summer dessert',
            'text': 'Transform this photo into a traditional Malai Kulfi on a stick. Add visible strands of saffron and pieces of almonds. The kulfi should have a realistic frozen texture. Background is a sunlit Indian summer afternoon.',
          },
          {
            'title': 'Pancake Stack Heights',
            'platform': 'Flux AI',
            'description': 'The ultimate fluffy pancake photo',
            'text': 'Modify this photo into a tall stack of fluffy pancakes. Add a drizzle of honey and a few blueberries on top. The background is an aesthetic breakfast table. Use soft, warm, appetizing lighting. 8k resolution.',
          },
        ];

      case 'Coffee Cafe':
        return [
          {
            'title': 'The Perfect Latte Art',
            'platform': 'Midjourney',
            'description': 'Add professional foam art to your coffee',
            'text': 'Transform this photo of a coffee cup to have a perfect, intricate "Swan" or "Tulip" latte art design in the foam. The coffee should look creamy. Set the background to a cozy, dark-wood cafe with books and a soft lamp.',
          },
          {
            'title': 'Rainy Day Cafe Vibe',
            'platform': 'Leonardo AI',
            'description': 'Move your photo to a cozy window seat',
            'text': 'Take the person/cup from this photo and place them at a window seat in a cafe. It should be raining outside with droplets on the glass. Add a warm, glowing atmosphere inside. Cinematic, moody lighting. Maintain the original face/object.',
          },
          {
            'title': 'Iced Coffee Aesthetic',
            'platform': 'DALL-E 3',
            'description': 'Add ice, milk swirls, and sunshine',
            'text': 'Recreate this photo as a trendy Iced Latte. Add realistic ice cubes, beautiful swirls of milk mixing with coffee, and a glass straw. The background should be a bright, sun-drenched marble table with a green plant.',
          },
          {
            'title': 'Coffee & Journaling',
            'platform': 'Midjourney',
            'description': 'A peaceful "Study with Me" aesthetic',
            'text': 'Modify this photo to include a stylish journal, a fountain pen, and a pair of glasses next to the coffee cup. The setting should be an aesthetic, minimalist workspace. Soft natural light. Clean and productive vibe.',
          },
          {
            'title': 'Coffee Roastery Industrial',
            'platform': 'Stable Diffusion XL',
            'description': 'A cool, masculine coffee shop theme',
            'text': 'Transform this photo into an industrial-style coffee roastery. Background features exposed brick walls, black metal pipes, and bags of coffee beans. Use high-contrast lighting and a sharp, modern aesthetic. Maintain the subject.',
          },
          {
            'title': 'Cappuccino Dusting',
            'platform': 'Leonardo AI',
            'description': 'Add cocoa or cinnamon art',
            'text': 'Take this coffee photo and add a thick layer of froth with a cocoa powder stencil of a heart or a star. Add a small cinnamon stick on the saucer. Warm, inviting cafe lighting. Professional beverage photography.',
          },
          {
            'title': 'Outdoor Garden Cafe',
            'platform': 'Midjourney',
            'description': 'A fresh and floral European cafe look',
            'text': 'Place the subject of this photo in a beautiful European outdoor cafe. Surround them with flower pots and wrought iron furniture. Bright, sunny afternoon lighting. Travel lifestyle photography style. Maintain the face.',
          },
          {
            'title': 'Barista at Work',
            'platform': 'DALL-E 3',
            'description': 'Add a professional barista background',
            'text': 'Modify this photo to show a professional barista pouring milk into the cup in the background. Focus on the coffee machine and the steam. Authentic cafe atmosphere. Sharp focus on the foreground subject. High resolution.',
          },
          {
            'title': 'Night Coffee Studio',
            'platform': 'Leonardo AI',
            'description': 'A dark, artistic coffee portrait',
            'text': 'Recreate this photo as a dark, artistic studio shot of a coffee cup. Use a single spotlight to highlight the steam and the rim of the cup. Black background, very dramatic and high-end. Commercial quality.',
          },
          {
            'title': 'Bakery & Brew',
            'platform': 'Flux AI',
            'description': 'Add fresh croissants to your coffee photo',
            'text': 'Transform this photo to show a coffee cup next to a plate of flaky, golden-brown croissants. The background is a bustling morning bakery. Warm, bright, and energetic lighting. Realistic food and drink textures.',
          },
        ];

      case 'Restaurant Setup':
        return [
          {
            'title': 'Rooftop City Dinner',
            'platform': 'Midjourney',
            'description': 'Place yourself in a high-end rooftop bar',
            'text': 'Transform this photo to show the person sitting at a luxury rooftop restaurant at night. The background should be a spectacular city skyline with twinkling lights. Elegant table setting with wine. Maintain the face and expression.',
          },
          {
            'title': 'Romantic Candlelight Date',
            'platform': 'Leonardo AI',
            'description': 'Create a perfect dinner date scene',
            'text': 'Recreate this photo as a romantic candlelight dinner. Add multiple candles on the table, red roses, and soft, warm ambient lighting. The atmosphere should be intimate and high-end. Maintain the person\'s face and clothes.',
          },
          {
            'title': 'Vintage Italian Trattoria',
            'platform': 'DALL-E 3',
            'description': 'A cozy, traditional European dinner',
            'text': 'Take the person from this photo and place them in a cozy, rustic Italian restaurant. Add a red-checkered tablecloth, a bottle of wine, and warm wooden interiors. Dim, atmospheric lighting. Maintain the face and identity.',
          },
          {
            'title': 'Luxury Hotel Buffet',
            'platform': 'Midjourney',
            'description': 'A grand and lavish food display background',
            'text': 'Modify this photo to show the person at a grand 5-star hotel buffet. Background should show endless rows of gourmet food, ice sculptures, and professional chefs. Bright, opulent lighting. Maintain the original face.',
          },
          {
            'title': 'Beachside Fine Dining',
            'platform': 'Stable Diffusion XL',
            'description': 'Dinner by the ocean at sunset',
            'text': 'Transform this photo into a beachside dining scene. Place the person at a table on the sand during a purple sunset. Add lanterns and the sound of waves. Soft, romantic lighting. Maintain the face identity.',
          },
          {
            'title': 'Modern Minimalist Bistro',
            'platform': 'Leonardo AI',
            'description': 'A clean and trendy restaurant look',
            'text': 'Recreate this photo in a modern minimalist bistro. Background features clean white walls, marble tables, and designer lighting. The person should look stylish and professional. High-end lifestyle photography. Maintain face.',
          },
          {
            'title': 'Garden Gazebo Dinner',
            'platform': 'Midjourney',
            'description': 'A private and magical garden setting',
            'text': 'Place the subject of this photo inside a private garden gazebo decorated with white flowers and hanging fairy lights. Evening time with a soft blue sky. Magical and exclusive atmosphere. Maintain the original face.',
          },
          {
            'title': 'Underground Jazz Club',
            'platform': 'DALL-E 3',
            'description': 'A moody, musical restaurant vibe',
            'text': 'Modify this photo to show the person at a table in a dark, moody underground jazz club. A saxophone player is blurred in the background. Red neon accents and warm lamp lighting. Cool and atmospheric. Maintain face.',
          },
          {
            'title': 'Traditional Indian Courtyard',
            'platform': 'Leonardo AI',
            'description': 'Authentic heritage dining',
            'text': 'Transform this photo into a traditional Indian courtyard restaurant. Background includes stone carvings, a fountain, and traditional lanterns. The person should be at a low table with floor cushions. Cultural and elegant. Maintain face.',
          },
          {
            'title': 'Breakfast with a View',
            'platform': 'Flux AI',
            'description': 'Morning coffee with mountain views',
            'text': 'Convert this photo into a luxury hotel breakfast scene. The person is sitting on a balcony with a lavish breakfast spread, overlooking a massive mountain range or valley. Bright, fresh morning light. Maintain the face.',
          },
        ];

      case 'Chef Cooking':
        return [
          {
            'title': 'The Masterchef Wok',
            'platform': 'Midjourney',
            'description': 'See yourself as a pro chef with fire',
            'text': 'Transform the person in this photo into a professional chef. Change their outfit to a clean white chef\'s coat and hat. They should be tossing vegetables in a wok with a dramatic flame flare. Professional kitchen background. Maintain the face.',
          },
          {
            'title': 'Pastry Chef Art',
            'platform': 'Leonardo AI',
            'description': 'You decorating a luxury cake',
            'text': 'Recreate this person as a pastry chef. They should be carefully garnishing a beautiful multi-tier cake with a delicate tool. Background is a high-end bakery. Soft, clean lighting and flour-dusted surfaces. Maintain the face.',
          },
          {
            'title': 'Artisan Bread Baker',
            'platform': 'DALL-E 3',
            'description': 'A rustic and warm baking transformation',
            'text': 'Take the person from this photo and turn them into an artisan baker. They should be holding a fresh, crusty loaf of sourdough bread. Background is a warm stone oven and sacks of flour. Rustic, cozy lighting. Maintain face.',
          },
          {
            'title': 'Sushi Master Precision',
            'platform': 'Midjourney',
            'description': 'A clean and focused Japanese chef look',
            'text': 'Modify this photo to show the person as a sushi chef. They should be using a sharp knife to slice fresh fish. Background is a minimalist Japanese sushi bar. Bright, clean, and clinical lighting. Maintain the face identity.',
          },
          {
            'title': 'Gourmet Plating Action',
            'platform': 'Stable Diffusion XL',
            'description': 'The final touch on a 5-star dish',
            'text': 'Transform this photo to show the person placing a tiny herb garnish on a luxury dish with tweezers. They should be wearing a black chef’s coat. Focused, professional expression. High-end fine dining kitchen. Maintain face.',
          },
          {
            'title': 'Pizza Toss Pro',
            'platform': 'Leonardo AI',
            'description': 'A fun and energetic chef pose',
            'text': 'Recreate this photo showing the person tossing a pizza dough in the air. Add a traditional wood-fired oven in the background. Joyful and energetic chef vibe. Flour particles in the air. Maintain the original face.',
          },
          {
            'title': 'The Spice Master',
            'platform': 'Midjourney',
            'description': 'A colorful Indian chef transformation',
            'text': 'Take the person from this photo and show them as an Indian spice master. They should be dropping vibrant red chili powder and yellow turmeric into a pan. A cloud of colorful spices in the air. Maintain the face features.',
          },
          {
            'title': 'Butcher Shop Expert',
            'platform': 'DALL-E 3',
            'description': 'A tough and professional butcher look',
            'text': 'Modify this photo to show the person as a professional butcher in an apron. They should be standing in a high-end meat shop with hanging cuts of meat. Masculine, professional, and sharp. Maintain the person’s identity.',
          },
          {
            'title': 'Molecular Gastronomy',
            'platform': 'Leonardo AI',
            'description': 'A high-tech scientific chef vibe',
            'text': 'Transform this photo into a molecular gastronomy scene. The person is using liquid nitrogen, creating a thick cloud of white vapor over a dish. High-tech kitchen equipment. Dramatic blue and white lighting. Maintain face.',
          },
          {
            'title': 'The Happy Home Cook',
            'platform': 'Flux AI',
            'description': 'A warm and friendly kitchen portrait',
            'text': 'Convert this photo into a "Happy Home Cook" portrait. The person is in a beautiful, sunlit kitchen, wearing an apron, and tasting something from a wooden spoon. Authentic, warm, and friendly. Maintain the face identity.',
          },
        ];

      default:
        return [];
    }
  }
}