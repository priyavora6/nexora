// lib/services/seed/prompts/nature_landscapes_prompts.dart

class NatureLandscapesPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Mountains':
        return [
          {
            'title': 'Himalayan Peak Trek',
            'platform': 'Midjourney',
            'description': 'Place yourself on a snowy mountain peak',
            'text': 'Transform this photo to show the person standing at the summit of a snowy Himalayan mountain. Background features jagged peaks and a deep blue sky. The person should be wearing professional trekking gear. Add a realistic lens flare from the sun. Maintain the exact face and expression.',
          },
          {
            'title': 'Misty Blue Mountains',
            'platform': 'Leonardo AI',
            'description': 'A serene and atmospheric mountain view',
            'text': 'Recreate this photo with a background of endless blue mountain ranges covered in thick morning mist. Dappled sunlight should hit the person. The style should be like a National Geographic landscape shot. Soft, ethereal lighting. Maintain the person’s identity.',
          },
          {
            'title': 'Rocky Adventure Trail',
            'platform': 'DALL-E 3',
            'description': 'Convert your photo into a hiking scene',
            'text': 'Take the person from this photo and place them on a narrow rocky trail on a steep mountain side. Include vast green valleys below and pine trees. Bright natural daylight. The person should look adventurous and sharp. Maintain face features.',
          },
          {
            'title': 'Volcanic Ash Landscape',
            'platform': 'Midjourney',
            'description': 'A dramatic and dark mountain theme',
            'text': 'Modify this photo to show the person in a dramatic volcanic mountain landscape with black sand and smoke in the distance. Intense lighting and high contrast. The mood should be epic and powerful. Maintain the original face perfectly.',
          },
          {
            'title': 'Alpine Flower Meadow',
            'platform': 'Stable Diffusion XL',
            'description': 'A colorful spring mountain makeover',
            'text': 'Transform this photo into a beautiful Alpine scene. Place the person in a vast field of purple and yellow wildflowers with snow-capped mountains in the background. Bright, cheerful morning lighting. Professional landscape photography style. Maintain face.',
          },
          {
            'title': 'Tibetan Plateau Spirit',
            'platform': 'Leonardo AI',
            'description': 'A cultural and high-altitude look',
            'text': 'Recreate this photo showing the person at a high-altitude Tibetan plateau. Add colorful prayer flags fluttering in the wind and a clear, thin atmosphere. The person should have a peaceful expression. Maintain the recognizable face.',
          },
          {
            'title': 'Autumn Hillside Glow',
            'platform': 'Midjourney',
            'description': 'Golden mountains in the fall',
            'text': 'Take the person from this photo and place them on a mountain slope during autumn. The trees should be brilliant shades of orange and red. Warm golden hour sunlight. Cinematic depth of field. Maintain the original face and hair.',
          },
          {
            'title': 'Steep Cliff Edge',
            'platform': 'DALL-E 3',
            'description': 'An intense and cinematic mountain shot',
            'text': 'Modify this photo to show the person sitting on the edge of a massive granite cliff overlooking a deep canyon. Dramatic clouds and epic scale. The lighting should be moody and grand. Maintain the person’s identity and pose.',
          },
          {
            'title': 'Swiss Chalet Vibe',
            'platform': 'Stable Diffusion XL',
            'description': 'A cozy luxury mountain lifestyle',
            'text': 'Transform this photo into a luxury mountain holiday. Place the person on a wooden balcony of a Swiss chalet with the Alps visible behind. Add a cozy atmosphere and soft evening light. Maintain the person’s face features.',
          },
          {
            'title': 'Winter Expedition',
            'platform': 'Flux AI',
            'description': 'A tough and realistic arctic look',
            'text': 'Convert this photo into a winter expedition shot. Add heavy snow-covered gear and goggles on the head. The background is a white-out blizzard on a mountain. Realistic ice crystals on the clothing. Maintain the face.',
          },
        ];

      case 'Beach Ocean':
        return [
          {
            'title': 'Maldives Turquoise Dream',
            'platform': 'Midjourney',
            'description': 'Place yourself in crystal clear water',
            'text': 'Transform this photo to show the person wading in crystal clear turquoise ocean water in the Maldives. Background includes white sand and a distant tropical island. Bright, vibrant tropical sunlight. Maintain the face and smile.',
          },
          {
            'title': 'Stormy Seascape Drama',
            'platform': 'Leonardo AI',
            'description': 'Add powerful crashing waves',
            'text': 'Recreate this photo with a background of a dark, stormy ocean and massive waves crashing against jagged rocks. Dramatic dark clouds and moody blue lighting. The person should look intense and strong. Maintain the original face.',
          },
          {
            'title': 'Sunset Shoreline Walk',
            'platform': 'DALL-E 3',
            'description': 'Golden hour at the beach',
            'text': 'Take the person from this photo and place them walking on a wet shoreline at sunset. The sun should be reflecting perfectly on the sand and water. Warm orange and purple sky. Soft, romantic lighting. Maintain face features.',
          },
          {
            'title': 'Underwater Coral World',
            'platform': 'Midjourney',
            'description': 'A surreal underwater transformation',
            'text': 'Modify this photo to show the person swimming underwater in a vibrant coral reef. Add colorful fish and sunlight rays piercing through the water surface. Ethereal and magical atmosphere. Maintain the original facial features.',
          },
          {
            'title': 'Remote Island Palms',
            'platform': 'Stable Diffusion XL',
            'description': 'A peaceful "Castaway" style look',
            'text': 'Transform this photo into a remote desert island setting. Surround the person with leaning palm trees and lush tropical plants. The ocean should be a calm emerald green. Natural, raw island vibe. Maintain face identity.',
          },
          {
            'title': 'Moonlight Sea Reflection',
            'platform': 'Leonardo AI',
            'description': 'A magical night-time beach theme',
            'text': 'Recreate this portrait at a beach during a full moon night. The person should be lit by silver moonlight with the dark ocean reflecting the moon behind them. Deep blue and silver color palette. Maintain the recognizable face.',
          },
          {
            'title': 'Surf Action Wave',
            'platform': 'Midjourney',
            'description': 'Add a high-energy surf vibe',
            'text': 'Take the person from this photo and place them on a surfboard inside a giant barreling wave. Add realistic water spray and motion blur. High-speed action photography style. Maintain the original face and focused expression.',
          },
          {
            'title': 'Coastal Cave Discovery',
            'platform': 'DALL-E 3',
            'description': 'A mysterious and unique location',
            'text': 'Modify this photo to show the person inside a dramatic sea cave looking out towards the ocean. Silhouette effect with high detail on the person. Magical lighting and ancient rock textures. Maintain the person’s identity.',
          },
          {
            'title': 'Luxury Beach Club',
            'platform': 'Stable Diffusion XL',
            'description': 'A trendy summer holiday look',
            'text': 'Transform this photo into a luxury beach club setting. Place the person on a white sunbed with a tropical drink. Add infinity pool views and palm trees in the background. Bright, high-end lifestyle photography. Maintain face.',
          },
          {
            'title': 'Lighthouse Cliff View',
            'platform': 'Flux AI',
            'description': 'A classic and scenic coastal shot',
            'text': 'Convert this photo into a scenic coastal view. Place the person on a grassy cliff with a red and white lighthouse in the background. Moody Atlantic ocean vibes. Professional travel photography style. Maintain the face.',
          },
        ];

      case 'Forest Jungle':
        return [
          {
            'title': 'Amazon Jungle Expedition',
            'platform': 'Midjourney',
            'description': 'A deep and lush jungle transformation',
            'text': 'Transform this photo to show the person deep in the Amazon rainforest. Surround them with giant fern leaves, colorful exotic birds, and thick vines. Dappled sunlight through the canopy. Maintain the exact facial features.',
          },
          {
            'title': 'Sunbeams in Pine Forest',
            'platform': 'Leonardo AI',
            'description': 'Add magical "God Rays" to your photo',
            'text': 'Recreate this photo in a tall pine forest during early morning. Add dramatic sunbeams (God rays) piercing through the mist and hitting the person. Soft green and golden tones. Serene and peaceful. Maintain the original face.',
          },
          {
            'title': 'Enchanted Glowing Woods',
            'platform': 'DALL-E 3',
            'description': 'A magical fantasy forest theme',
            'text': 'Take the person from this photo and place them in an enchanted forest at night. Add glowing mushrooms, floating magical particles, and bioluminescent trees. Dreamy, surreal lighting. Maintain face features perfectly.',
          },
          {
            'title': 'Autumn Leaf Trail',
            'platform': 'Midjourney',
            'description': 'A warm and colorful fall makeover',
            'text': 'Modify this photo to show the person walking on a forest trail covered in deep orange and red fallen leaves. The trees should be in full autumn color. Warm, nostalgic atmosphere. Maintain the face identity.',
          },
          {
            'title': 'Bamboo Grove Zen',
            'platform': 'Stable Diffusion XL',
            'description': 'A clean and peaceful Japanese style',
            'text': 'Transform this photo into a peaceful Zen bamboo forest. Surround the person with tall, green bamboo stalks. Use soft, diffused lighting and a minimalist aesthetic. Peaceful and quiet atmosphere. Maintain face identity.',
          },
          {
            'title': 'Ancient Giant Redwoods',
            'platform': 'Leonardo AI',
            'description': 'Epic scale with massive trees',
            'text': 'Recreate this portrait in a forest of giant Redwood trees. The scale should be massive, making the person look small against the ancient trunks. Soft moss and ferns on the ground. Professional nature photography. Maintain face.',
          },
          {
            'title': 'Foggy Spooky Forest',
            'platform': 'Midjourney',
            'description': 'A moody and mysterious theme',
            'text': 'Take the person from this photo and place them in a dark, foggy forest with twisted tree branches. Low-key lighting and a mysterious, cinematic atmosphere. High contrast and sharp details. Maintain the original face.',
          },
          {
            'title': 'Tropical Palm Jungle',
            'platform': 'DALL-E 3',
            'description': 'A vibrant island forest look',
            'text': 'Modify this photo to show the person in a vibrant tropical palm jungle. Add large banana leaves and hibiscus flowers. The lighting should be bright and hot. Vibrant colors and high resolution. Maintain the person’s identity.',
          },
          {
            'title': 'Cherry Blossom Spring',
            'platform': 'Stable Diffusion XL',
            'description': 'A beautiful pink floral makeover',
            'text': 'Transform this photo into a Japanese spring forest. Place the person under blooming cherry blossom trees with pink petals falling like snow. Soft, romantic pastel lighting. Maintain the face features.',
          },
          {
            'title': 'Forest Stream Splash',
            'platform': 'Flux AI',
            'description': 'A fresh and natural outdoor scene',
            'text': 'Convert this photo to show the person sitting by a crystal clear forest stream. Add mossy rocks and small fish in the water. Fresh, clean morning lighting. Realistic water reflections. Maintain the face identity.',
          },
        ];

      case 'Sunset Sunrise':
        return [
          {
            'title': 'Fiery Red Clouds',
            'platform': 'Midjourney',
            'description': 'Add a dramatic sunset sky to your photo',
            'text': 'Transform this photo to show the person against a breathtaking fiery red and orange sunset. The clouds should be dramatic and highly detailed. Warm light reflecting on the person’s face. Maintain the exact face and expression.',
          },
          {
            'title': 'Golden Morning Mist',
            'platform': 'Leonardo AI',
            'description': 'A soft and peaceful sunrise theme',
            'text': 'Recreate this photo at dawn. Add a heavy golden mist over a valley background. The sun should be just peeking over the horizon, creating a soft glow. Ethereal and calm atmosphere. Maintain the person’s identity.',
          },
          {
            'title': 'Purple Twilight Sky',
            'platform': 'DALL-E 3',
            'description': 'A moody and aesthetic twilight look',
            'text': 'Take the person from this photo and place them under a deep purple and magenta twilight sky. Add the first few stars appearing. The silhouette of the person should be sharp and recognizable. Maintain face features.',
          },
          {
            'title': 'Desert Horizon Sun',
            'platform': 'Midjourney',
            'description': 'A vast and epic desert sunset',
            'text': 'Modify this photo to show the person in a vast desert with a giant sun setting on the horizon. Long shadows and golden sand dunes. Cinematic scale and epic lighting. Maintain the original face perfectly.',
          },
          {
            'title': 'City Skyline Sunset',
            'platform': 'Stable Diffusion XL',
            'description': 'An urban golden hour makeover',
            'text': 'Transform this photo into an urban sunset scene. Place the person on a balcony with a city skyline glowing in the evening sun. Modern, trendy lifestyle photography style. Maintain the face identity.',
          },
          {
            'title': 'Ocean Horizon Sunrise',
            'platform': 'Leonardo AI',
            'description': 'A fresh and inspiring morning look',
            'text': 'Recreate this portrait at the beach during sunrise. The sun should be a perfect circle rising from the ocean. Clear sky with pastel pink tones. Fresh and hopeful mood. Maintain the recognizable face.',
          },
          {
            'title': 'Sun Rising Through Trees',
            'platform': 'Midjourney',
            'description': 'A natural and organic morning shot',
            'text': 'Take the person from this photo and place them in a forest where the sunrise is filtering through the tree branches. Add lens flare and warm morning glow. Natural and authentic. Maintain the original face.',
          },
          {
            'title': 'Intense Magic Hour',
            'platform': 'DALL-E 3',
            'description': 'The perfect professional lighting',
            'text': 'Modify this photo to have the perfect "Magic Hour" professional lighting. Skin should look glowing and warm. Background is a scenic overlook. High-end portrait photography style. Maintain the person’s identity.',
          },
          {
            'title': 'Stormy Sky Sunset',
            'platform': 'Stable Diffusion XL',
            'description': 'Dramatic and powerful sky theme',
            'text': 'Transform this photo to show a sunset happening during a storm. Dark blue clouds mixed with bright orange light. Powerful and atmospheric nature scene. Maintain the face features.',
          },
          {
            'title': 'Pastel Dawn Sky',
            'platform': 'Flux AI',
            'description': 'A soft and aesthetic morning vibe',
            'text': 'Convert this photo into a soft dawn scene. Sky should be a mix of pale blue, pink, and lemon yellow. Very soft, flattering lighting on the person. Aesthetic and peaceful. Maintain the face identity.',
          },
        ];

      case 'Waterfall River':
        return [
          {
            'title': 'Grand Canyon Waterfall',
            'platform': 'Midjourney',
            'description': 'Place yourself in an epic canyon scene',
            'text': 'Transform this photo to show the person standing in front of a massive, powerful waterfall inside a red-rock canyon. Add mist and a rainbow in the water spray. Cinematic scale and epic lighting. Maintain the exact face.',
          },
          {
            'title': 'Gentle Forest Brook',
            'platform': 'Leonardo AI',
            'description': 'A peaceful and natural river theme',
            'text': 'Recreate this photo by a gentle, clear forest stream. Add mossy rocks and sunlight reflecting on the moving water. The person should look relaxed and at peace with nature. Maintain the original face.',
          },
          {
            'title': 'Winding Blue River',
            'platform': 'DALL-E 3',
            'description': 'An aerial-style river landscape',
            'text': 'Take the person from this photo and place them on a high cliff overlooking a winding blue river through a green valley. Epic perspective and sharp details. Bright natural daylight. Maintain face features.',
          },
          {
            'title': 'Hidden Jungle Falls',
            'platform': 'Midjourney',
            'description': 'Discover a secret waterfall',
            'text': 'Modify this photo to show the person discovering a secret waterfall deep in a tropical jungle. Lush vines and exotic flowers surround the pool. Ethereal and adventurous atmosphere. Maintain the original face.',
          },
          {
            'title': 'Frozen Winter Waterfall',
            'platform': 'Stable Diffusion XL',
            'description': 'A unique and cold nature makeover',
            'text': 'Transform this photo into a winter scene. The background is a massive waterfall that has completely frozen into ice crystals. Snow everywhere and cold blue lighting. Maintain the face identity.',
          },
          {
            'title': 'Sacred River Ghats',
            'platform': 'Leonardo AI',
            'description': 'A spiritual and cultural river theme',
            'text': 'Recreate this portrait at the ancient river ghats of Varanasi. Add stone steps, temple spires, and a spiritual evening atmosphere with diyas. Cultural and meaningful. Maintain the recognizable face.',
          },
          {
            'title': 'Multi-Tiered Cascade',
            'platform': 'Midjourney',
            'description': 'A beautiful tiered water scene',
            'text': 'Take the person from this photo and place them next to a beautiful multi-tiered cascading waterfall. Water should look silky with a long-exposure effect. Lush greenery and soft lighting. Maintain the original face.',
          },
          {
            'title': 'Rapid White Water',
            'platform': 'DALL-E 3',
            'description': 'Add an intense river adventure vibe',
            'text': 'Modify this photo to show the person on the banks of a powerful white-water river. Add splashing water and an energetic atmosphere. The person should look inspired by nature’s power. Maintain the person’s identity.',
          },
          {
            'title': 'Amazon Wide River',
            'platform': 'Stable Diffusion XL',
            'description': 'A vast and tropical river look',
            'text': 'Transform this photo into a vast Amazon river scene. Place the person on a wooden boat with the wide river and dense jungle stretching to the horizon. Sunset lighting. Maintain the face features.',
          },
          {
            'title': 'Mossy Rock Stream',
            'platform': 'Flux AI',
            'description': 'A high-detail macro nature shot',
            'text': 'Convert this photo into a high-detail forest stream scene. Focus on the textures of wet mossy rocks and clear water. Soft dappled sunlight. Professional nature photography style. Maintain the face identity.',
          },
        ];

      case 'Night Sky Stars':
        return [
          {
            'title': 'Milky Way Galaxy',
            'platform': 'Midjourney',
            'description': 'Add a stunning galaxy sky to your photo',
            'text': 'Transform this photo to show the person under a spectacular Milky Way galaxy sky. Millions of stars and colorful cosmic dust should be visible. Dark desert background. Cinematic night lighting. Maintain the exact face.',
          },
          {
            'title': 'Aurora Borealis Magic',
            'platform': 'Leonardo AI',
            'description': 'See yourself under the Northern Lights',
            'text': 'Recreate this photo with the Northern Lights (Aurora Borealis) dancing in the sky behind the person. Vibrant green and purple light trails. Snowy landscape background. Magical atmosphere. Maintain the person’s identity.',
          },
          {
            'title': 'Crescent Moon & Stars',
            'platform': 'DALL-E 3',
            'description': 'A soft and aesthetic night theme',
            'text': 'Take the person from this photo and place them on a balcony under a clear night sky with a bright crescent moon and twinkling stars. Peaceful and artistic. Soft rim lighting on the person. Maintain face features.',
          },
          {
            'title': 'Full Moon Reflection',
            'platform': 'Midjourney',
            'description': 'A romantic and moody moonlit shot',
            'text': 'Modify this photo to show the person by a still lake at night. A huge full moon is reflecting perfectly in the water. Deep blue tones and silver highlights. Atmospheric and calm. Maintain the original face.',
          },
          {
            'title': 'Starry Desert Night',
            'platform': 'Stable Diffusion XL',
            'description': 'An epic and vast night landscape',
            'text': 'Transform this photo into a desert night scene. The person is standing on a sand dune under a massive, clear starry sky. High contrast between the dark sand and bright stars. Maintain the face identity.',
          },
          {
            'title': 'Nebula Space Clouds',
            'platform': 'Leonardo AI',
            'description': 'A surreal and cosmic transformation',
            'text': 'Recreate this portrait with a surreal cosmic background. The person should look like they are floating in space surrounded by glowing nebulae and distant planets. Artistic and unique. Maintain the recognizable face.',
          },
          {
            'title': 'Shooting Star Wish',
            'platform': 'Midjourney',
            'description': 'Capture a magical moment',
            'text': 'Take the person from this photo and place them looking up at a night sky where a bright shooting star is crossing. Emotional and hopeful expression. Soft, magical lighting. Maintain the original face.',
          },
          {
            'title': 'Campfire Under Stars',
            'platform': 'DALL-E 3',
            'description': 'Add a cozy outdoor night vibe',
            'text': 'Modify this photo to show the person sitting by a small campfire under a vast starry sky. The orange firelight should reflect realistically on the person’s face. Cozy adventure atmosphere. Maintain the person’s identity.',
          },
          {
            'title': 'Constellation Map Sky',
            'platform': 'Stable Diffusion XL',
            'description': 'An educational and artistic look',
            'text': 'Transform this photo by adding scientific constellation lines and names to the night sky background. The sky should be a deep indigo with sharp stars. Creative and intellectual vibe. Maintain face features.',
          },
          {
            'title': 'Blue Twilight Night',
            'platform': 'Flux AI',
            'description': 'A clean and modern night shot',
            'text': 'Convert this photo into a high-end night portrait. The sky is a deep electric blue with a few bright stars. Use sharp, professional night photography lighting on the person. Maintain the face identity.',
          },
        ];

      default:
        return [];
    }
  }
}
