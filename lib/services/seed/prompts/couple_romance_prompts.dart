
// lib/services/seed/prompts/couple_romance_prompts.dart

class CoupleRomancePrompts {
  static List<Map<String, dynamic>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Valentine Special':
        return [
          {
            'title': 'Romantic Candlelight Dinner',
            'platform': 'Midjourney',
            'description': 'Intimate dinner setting for two',
            'text': 'Cinematic shot of a romantic candlelight dinner for an Indian couple on a rooftop, soft warm lighting, rose petals on table, city skyline in background, bokeh effect, elegant evening wear, 8K --ar 16:9 --v 6.0',
          },
          {
            'title': 'Heart-shaped Balloons Surprise',
            'platform': 'DALL-E 3',
            'description': 'Surprise room decoration',
            'text': 'A room filled with red heart-shaped balloons, an Indian man surprising his partner, joyful expressions, warm cozy lighting, professional photography, romantic atmosphere.',
          },
          {
            'title': 'Rooftop Picnic at Sunset',
            'platform': 'Leonardo AI',
            'description': 'Boho style rooftop setup',
            'text': 'Indian couple enjoying a cozy picnic on a rooftop, fairy lights, cushions, sunset golden hour, wine glasses, snacks, urban background, soft focus, dreamy atmosphere.',
          },
          {
            'title': 'Gift Exchange Moment',
            'platform': 'Midjourney',
            'description': 'Close up of giving a gift',
            'text': 'Close up shot of an Indian man hands giving a small red velvet jewelry box to his partner, soft romantic lighting, blurred background of a decorated room, high detail --ar 4:5',
          },
          {
            'title': 'Romantic Walk in Flower Garden',
            'platform': 'Midjourney',
            'description': 'Walking through tulips',
            'text': 'Young Indian couple walking through a garden of red tulips, holding hands, smiling at each other, bright spring morning, cinematic lighting, 8k resolution --ar 16:9',
          },
          {
            'title': 'Cozy Movie Night',
            'platform': 'DALL-E 3',
            'description': 'Watching movie under blankets',
            'text': 'Indian couple wrapped in a warm blanket on a sofa, watching a movie on a projector, popcorn, room lit by warm string lights, cozy and intimate atmosphere.',
          },
          {
            'title': 'Cooking Together Valentine',
            'platform': 'Leonardo AI',
            'description': 'Baking a heart cake',
            'text': 'Playful Indian couple in a modern kitchen, flour on faces, baking a heart-shaped cake together, sunlight coming through window, high detail, candid photography.',
          },
          {
            'title': 'Slow Dance in Living Room',
            'platform': 'Midjourney',
            'description': 'Dance under dim lights',
            'text': 'Indian couple slow dancing in a dim living room, only lit by a fireplace and candles, shadows on wall, romantic mood, cinematic grain, photorealistic --ar 16:9',
          },
          {
            'title': 'Stargazing Date',
            'platform': 'DALL-E 3',
            'description': 'Looking at night sky',
            'text': 'Indian couple lying on the grass next to a telescope, looking up at a vibrant milky way galaxy sky, deep blues and purples, romantic and mystical vibe.',
          },
          {
            'title': 'Valentine Portrait Studio',
            'platform': 'Midjourney',
            'description': 'Formal romantic portrait',
            'text': 'Professional studio portrait of an Indian couple, red and black theme, elegant poses, high contrast lighting, fashion magazine style, 8k --v 6.0',
          },
        ];

      case 'Engagement Proposal':
        return [
          {
            'title': 'Beachside Ring Proposal',
            'platform': 'Leonardo AI',
            'description': 'Sunset proposal on beach',
            'text': 'Indian man kneeling on one knee, proposing with a diamond ring to his girlfriend on a serene beach at sunset, waves in background, golden hour lighting, emotional and high detail.',
          },
          {
            'title': 'Royal Palace Proposal',
            'platform': 'Midjourney',
            'description': 'Proposal in Rajasthan palace',
            'text': 'Indian man proposing to his partner in the courtyard of a majestic Rajasthani palace, intricate stone carvings, evening torch lights, cinematic wide shot, royal vibe --ar 16:9',
          },
          {
            'title': 'Hot Air Balloon Proposal',
            'platform': 'DALL-E 3',
            'description': 'Proposal in the sky',
            'text': 'An Indian man proposing with a ring inside a hot air balloon basket, panoramic view of a scenic valley below at sunrise, clouds, breathtaking perspective.',
          },
          {
            'title': 'Surprise Family Proposal',
            'platform': 'Midjourney',
            'description': 'Proposal with family hiding',
            'text': 'Candid shot of an Indian proposal in a backyard, "Will You Marry Me" neon sign, family and friends peeking from behind curtains, emotional expressions, bokeh --ar 3:2',
          },
          {
            'title': 'Snowy Mountain Proposal',
            'platform': 'Leonardo AI',
            'description': 'Proposal in the snow',
            'text': 'Man in heavy winter wear proposing to a woman in a red coat on a snowy mountain peak, blue sky, white snow everywhere, diamond ring sparkling, high detail.',
          },
          {
            'title': 'Library Hidden Ring',
            'platform': 'DALL-E 3',
            'description': 'Proposal in old library',
            'text': 'A couple in an old vintage library, the man opening a hollowed-out book to reveal an engagement ring, warm library lighting, dust motes in sunbeams.',
          },
          {
            'title': 'Forest Trail Surprise',
            'platform': 'Midjourney',
            'description': 'Proposal under giant oak',
            'text': 'Enchanted forest setting, sun rays filtering through leaves, Indian man proposing on a wooden bridge, ethereal and magical atmosphere, 8k resolution --ar 16:9',
          },
          {
            'title': 'Flash Mob Proposal',
            'platform': 'DALL-E 3',
            'description': 'Public urban proposal',
            'text': 'A crowded city square, dancers in the background, a man kneeling in the center, woman surprised with hands over mouth, colorful city vibes, daytime.',
          },
          {
            'title': 'Underwater Proposal Concept',
            'platform': 'Leonardo AI',
            'description': 'Proposal while scuba diving',
            'text': 'Conceptual art of a couple scuba diving in clear blue water, man holding a sign "Marry Me?", bubbles, coral reef, exotic fish, unique perspective.',
          },
          {
            'title': 'First Date Spot Proposal',
            'platform': 'Midjourney',
            'description': 'Proposal at a cafe',
            'text': 'Simple and sweet proposal at a local coffee shop where they first met, coffee cups on table, rainy window, man holding the ring across the table --ar 4:5',
          },
        ];

      case 'Couple Photoshoot':
        return [
          {
            'title': 'Traditional Ethnic Photoshoot',
            'platform': 'Midjourney',
            'description': 'Couple in ethnic wear',
            'text': 'Indian couple in traditional designer ethnic wear, standing in a royal palace courtyard, intricate embroidery, majestic architecture, soft sunlight, high fashion photography --ar 4:5 --v 6.0',
          },
          {
            'title': 'Modern Urban Streetwear',
            'platform': 'DALL-E 3',
            'description': 'Cool urban couple',
            'text': 'Indian couple wearing trendy streetwear, standing against a graffiti wall in a modern city, neon lights, cool poses, urban fashion photography, high contrast.',
          },
          {
            'title': 'Black and White Classic',
            'platform': 'Midjourney',
            'description': 'Timeless B&W portrait',
            'text': 'Classic black and white portrait of an Indian couple, vintage film grain, dramatic shadows, emotional connection, focused on facial expressions, 35mm film style.',
          },
          {
            'title': 'Retro 70s Bollywood Style',
            'platform': 'Leonardo AI',
            'description': 'Vintage film look',
            'text': 'Indian couple dressed in 1970s retro fashion, bell-bottoms and vintage sunglasses, posing next to an old Ambassador car, grainy film aesthetic, warm vintage colors.',
          },
          {
            'title': 'Golden Hour Field',
            'platform': 'Midjourney',
            'description': 'Sunset in wheat field',
            'text': 'Indian couple standing in a golden wheat field during sunset, backlight creating a glow around them, romantic, soft focus, nature photography --ar 16:9',
          },
          {
            'title': 'Industrial Chic Studio',
            'platform': 'DALL-E 3',
            'description': 'Minimalist industrial vibe',
            'text': 'Couple posing in a minimalist industrial loft, exposed brick walls, large windows, sleek modern outfits, professional studio lighting, high-end look.',
          },
          {
            'title': 'Traditional Village Vibe',
            'platform': 'Leonardo AI',
            'description': 'Rural Indian setting',
            'text': 'Indian couple in simple cotton ethnic wear, sitting on a charpai outside a traditional hut, marigold flowers, authentic rural atmosphere, warm sunlight.',
          },
          {
            'title': 'Neon Night Cityscape',
            'platform': 'Midjourney',
            'description': 'Tokyo-style neon lights',
            'text': 'Indian couple walking through a rainy city street at night, vibrant neon signs reflecting in puddles, cinematic cyberpunk aesthetic, high detail --ar 16:9',
          },
          {
            'title': 'Art Gallery Date',
            'platform': 'DALL-E 3',
            'description': 'Sophisticated gallery setting',
            'text': 'Couple dressed in sophisticated minimal outfits, looking at a large abstract painting in a white-walled art gallery, soft lighting, intellectual and calm vibe.',
          },
          {
            'title': 'Desert Sand Dunes',
            'platform': 'Midjourney',
            'description': 'Epic desert landscape',
            'text': 'Indian couple standing on top of a vast sand dune at twilight, wind blowing clothes, epic cinematic scale, starry sky starting to appear, National Geographic style --ar 21:9',
          },
        ];

      case 'Pre-Wedding':
        return [
          {
            'title': 'Cinematic Pre-Wedding Walk',
            'platform': 'Midjourney',
            'description': 'Couple walking in nature',
            'text': 'Beautiful Indian couple walking hand-in-hand through a lush green garden, pre-wedding photoshoot style, flowing gowns, sunlight filtering through trees, dreamy and romantic --ar 16:9 --v 6.0',
          },
          {
            'title': 'Udaipur Boat Ride',
            'platform': 'DALL-E 3',
            'description': 'Romantic boat on Lake Pichola',
            'text': 'Indian couple on a traditional wooden boat in Udaipur, Taj Lake Palace in the background, calm water, sunset, orange and pink sky, extremely romantic.',
          },
          {
            'title': 'Historical Monument Grandeur',
            'platform': 'Midjourney',
            'description': 'Posing at Taj Mahal',
            'text': 'Indian couple in grand attire posing in front of the Taj Mahal at dawn, mist over the gardens, cinematic framing, symmetrical composition, 8k resolution.',
          },
          {
            'title': 'Playful Haldi Theme',
            'platform': 'Leonardo AI',
            'description': 'Yellow theme fun shots',
            'text': 'Couple in yellow outfits throwing flower petals at each other, laughing, bright sunlight, festive and joyful pre-wedding mood, high detail, high speed photography.',
          },
          {
            'title': 'Vineyard Romantic Session',
            'platform': 'DALL-E 3',
            'description': 'Walking through grapevines',
            'text': 'A couple walking through a beautiful vineyard at sunset, holding glasses of wine, soft evening breeze, hills in the background, warm and elegant.',
          },
          {
            'title': 'Vintage Car Drive',
            'platform': 'Midjourney',
            'description': 'Couple in a convertible',
            'text': 'Indian couple driving a vintage red convertible car on a coastal road, hair blowing in the wind, cinematic colors, 60s film aesthetic, blue ocean background --ar 16:9',
          },
          {
            'title': 'Mountain Fog Romance',
            'platform': 'Leonardo AI',
            'description': 'Misty hills of Munnar',
            'text': 'Couple standing on a tea plantation hill, heavy fog and mist surrounding them, moody and atmospheric, holding each other closely, deep greens and greys.',
          },
          {
            'title': 'Old Heritage Haveli',
            'platform': 'Midjourney',
            'description': 'Intricate architecture shots',
            'text': 'Couple inside an old Haveli with stained glass windows, colored light falling on them, traditional rich textures, cinematic lighting, mysterious and beautiful --ar 4:5',
          },
          {
            'title': 'Whimsical Fairytale Forest',
            'platform': 'DALL-E 3',
            'description': 'Ethereal forest setup',
            'text': 'A couple standing in a forest filled with white flowers, hanging lanterns on trees, glowing fireflies, fairytale vibe, dreamy soft focus.',
          },
          {
            'title': 'Train Station Departure',
            'platform': 'Leonardo AI',
            'description': 'Cinematic railway station',
            'text': 'Indian couple at a vintage railway station, steam locomotive, man leaning out of the door, woman on platform holding his hand, emotional cinematic goodbye style.',
          },
        ];

      case 'Anniversary':
        return [
          {
            'title': 'Anniversary Celebration Cake',
            'platform': 'DALL-E 3',
            'description': 'Cutting anniversary cake',
            'text': 'Indian couple celebrating their 10th anniversary, cutting a beautiful tiered cake, family in background, warm lighting, festive mood, high detail.',
          },
          {
            'title': '25 Years of Togetherness',
            'platform': 'Midjourney',
            'description': 'Silver Jubilee older couple',
            'text': 'Elegant older Indian couple holding hands, 25th anniversary theme, silver decorations in background, graceful aging, wisdom and love in eyes, cinematic portrait.',
          },
          {
            'title': 'Renewing Vows Ceremony',
            'platform': 'Leonardo AI',
            'description': 'Intimate vow renewal',
            'text': 'Couple exchanging rings again in a small garden ceremony, close family present, emotional atmosphere, evening garden setting, soft string lights.',
          },
          {
            'title': 'Anniversary Travel Vlog',
            'platform': 'Midjourney',
            'description': 'Couple traveling together',
            'text': 'Indian couple taking a selfie in front of the Eiffel Tower, "Happy Anniversary" sign, joyful, travel photography style, sunny day, high resolution --ar 9:16',
          },
          {
            'title': 'Looking at Wedding Album',
            'platform': 'DALL-E 3',
            'description': 'Nostalgic home moment',
            'text': 'Couple sitting on a rug by a fireplace, looking through an old wedding photo album, smiling, nostalgia, warm and cozy indoor lighting.',
          },
          {
            'title': 'Sunrise Yoga Together',
            'platform': 'Leonardo AI',
            'description': 'Healthy lifestyle couple',
            'text': 'Fit Indian couple doing yoga together on a balcony overlooking the ocean at sunrise, peace and tranquility, high detail, morning light.',
          },
          {
            'title': 'Home Garden Dinner',
            'platform': 'Midjourney',
            'description': 'Simple intimate dinner',
            'text': 'Intimate anniversary dinner in a home garden, simple wooden table, one candle, focus on the couple faces, night time, soft bokeh --ar 16:9',
          },
          {
            'title': 'Dance through the Years',
            'platform': 'DALL-E 3',
            'description': 'Dancing in their new home',
            'text': 'Indian couple dancing in their modern living room, wall decorated with photos of them through the years, afternoon sun through window, peaceful.',
          },
          {
            'title': 'Breakfast in Bed Surprise',
            'platform': 'Leonardo AI',
            'description': 'Morning anniversary gift',
            'text': 'Man bringing a tray with breakfast and a rose to his wife in bed, sunlight, messy bed, cozy morning vibe, candid and heart-warming.',
          },
          {
            'title': 'Sunset Cruise Celebration',
            'platform': 'Midjourney',
            'description': 'Luxury yacht anniversary',
            'text': 'Indian couple on a luxury yacht, white outfits, holding champagne glasses, sea in background, sunset, high-end lifestyle photography --ar 16:9',
          },
        ];

      case 'Romantic Scenes':
        return [
          {
            'title': 'Couple in Rain',
            'platform': 'Leonardo AI',
            'description': 'Dancing in the rain',
            'text': 'Indian couple dancing joyfully in the rain under a single umbrella, street lights reflecting on wet pavement, romantic and moody, cinematic lighting.',
          },
          {
            'title': 'Morning Coffee on Balcony',
            'platform': 'Midjourney',
            'description': 'Quiet morning together',
            'text': 'Couple sharing a cup of coffee on a balcony, city waking up in background, misty morning, wearing cozy sweaters, soft natural light --ar 4:5',
          },
          {
            'title': 'Book Reading Together',
            'platform': 'DALL-E 3',
            'description': 'Intellectual connection',
            'text': 'Indian couple sitting in a cozy nook with hundreds of books, both reading but leaning against each other, soft afternoon light, peaceful and romantic.',
          },
          {
            'title': 'Autumn Park Bench',
            'platform': 'Midjourney',
            'description': 'Fall colors romance',
            'text': 'Couple sitting on a park bench surrounded by falling orange and red leaves, autumn season, whispering to each other, cinematic depth of field.',
          },
          {
            'title': 'Winter Bonfire Night',
            'platform': 'Leonardo AI',
            'description': 'Warmth in the cold',
            'text': 'Indian couple sitting by a crackling bonfire at night, wrapped in a pashmina shawl, fire light reflecting on faces, sparks flying into the night sky.',
          },
          {
            'title': 'Bicycle Ride for Two',
            'platform': 'DALL-E 3',
            'description': 'Playful romantic scene',
            'text': 'Indian couple on a vintage bicycle, woman sitting on the front bar, man pedaling, country road, flowers in the basket, nostalgic and playful.',
          },
          {
            'title': 'Shadow Play on Wall',
            'platform': 'Midjourney',
            'description': 'Creative lighting scene',
            'text': 'Silhouette of a couple kissing against a wall, large shadows, creative lighting, artistic and romantic, high contrast, minimal aesthetic.',
          },
          {
            'title': 'Beach Hammock Nap',
            'platform': 'Leonardo AI',
            'description': 'Relaxing tropical romance',
            'text': 'Couple napping together in a large hammock tied between two palm trees, turquoise ocean in background, tropical paradise, serene and calm.',
          },
          {
            'title': 'Kite Flying Together',
            'platform': 'DALL-E 3',
            'description': 'Terrace romantic activity',
            'text': 'Indian couple on a terrace, flying a colorful kite together, blue sky, wind blowing, traditional Indian terrace setting, joyful.',
          },
          {
            'title': 'Street Food Date',
            'platform': 'Midjourney',
            'description': 'Casual city romance',
            'text': 'Indian couple sharing a plate of pani puri at a vibrant street stall, evening lights, crowded market background, candid and authentic urban romance --ar 16:9',
          },
        ];

      default:
        return [];
    }
  }
}