// lib/services/seed/prompts/vehicles_travel_prompts.dart

class VehiclesTravelPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Sports Cars':
        return [
          {
            'title': 'The Supercar Transformation',
            'platform': 'Midjourney',
            'description': 'Convert your car into a high-end supercar',
            'text': 'Transform this car into a sleek, futuristic supercar. Change the body to a matte black carbon fiber finish with glowing neon accents. Place it on a rainy night street in a modern city with dramatic reflections. Professional automotive photography, 8k.',
          },
          {
            'title': 'Desert Speed Blur',
            'platform': 'Leonardo AI',
            'description': 'See your car racing through dunes',
            'text': 'Modify this car photo to show it racing through a vast desert at high speed. Add a realistic motion blur effect and dust clouds kicking up from the tires. Sunset lighting with a deep orange sky. Action-packed automotive shot.',
          },
          {
            'title': 'Luxury Showroom Glow',
            'platform': 'DALL-E 3',
            'description': 'Place your car in a premium showroom',
            'text': 'Recreate this car photo inside a high-end luxury car showroom. Use polished marble floors, cinematic spotlights, and a minimalist white background. The car should look brand new and extremely glossy with sharp reflections.',
          },
          {
            'title': 'Cyberpunk Ride Night',
            'platform': 'Midjourney',
            'description': 'A futuristic neon-lit makeover',
            'text': 'Transform this vehicle into a Cyberpunk 2077 style machine. Add glowing wheel rims, extra vents, and high-tech decals. The background is a rainy neon-lit city with blue and magenta lights. Intense and edgy atmosphere.',
          },
          {
            'title': 'Classic Vintage Style',
            'platform': 'Stable Diffusion XL',
            'description': 'Turn a modern car into a 1960s classic',
            'text': 'Recreate this car as a 1960s vintage classic model. Change the body style to a retro aesthetic with chrome bumpers and white-wall tires. The setting is a nostalgic coastal road in Italy. Soft, warm film-style lighting.',
          },
          {
            'title': 'Mountain Drift Action',
            'platform': 'Leonardo AI',
            'description': 'High-action mountain road drift',
            'text': 'Modify this car photo to show it drifting around a sharp mountain corner. Add tire smoke and a sense of extreme speed. The background is a scenic mountain pass with a deep valley below. Dramatic and powerful action shot.',
          },
          {
            'title': 'Gold Plated Luxury',
            'platform': 'Midjourney',
            'description': 'The ultimate rich-list car makeover',
            'text': 'Transform this car to have a mirror-finish gold plated body. The car should look incredibly expensive and reflective. Set the background to a luxury hotel entrance with a red carpet and paparazzi flashes in the blur.',
          },
          {
            'title': 'Racing Track Hero',
            'platform': 'DALL-E 3',
            'description': 'See your car on a professional circuit',
            'text': 'Place this car on a professional racing circuit. Add motion blur to the background and track lines. The car should have racing decals and a professional spoiler. Bright, clear daylight. High-speed track photography style.',
          },
          {
            'title': 'Winter Ice Drifter',
            'platform': 'Leonardo AI',
            'description': 'Cool blue snowy car theme',
            'text': 'Transform this car photo into a winter scene. The car should be driving through fresh snow with ice crystals forming on the body. Cold blue lighting and a snowy forest background. Sharp focus and high-quality textures.',
          },
          {
            'title': 'The Stealth Bomber Look',
            'platform': 'Flux AI',
            'description': 'All-black minimalist car design',
            'text': 'Modify this car to have a complete "Stealth" look. Everything from the rims to the windows should be deep matte black. Use low-key dramatic lighting in a dark industrial warehouse. Very sharp, aggressive, and modern.',
          },
        ];

      case 'Motorcycles':
        return [
          {
            'title': 'Ladakh Adventure Ride',
            'platform': 'Midjourney',
            'description': 'Place your bike in the Himalayas',
            'text': 'Transform this motorcycle photo into an epic adventure. Place the bike and rider on a high mountain pass in Ladakh. Background includes snowy peaks and a clear blue sky. Add dust on the bike and luggage bags. 8k cinematic travel shot.',
          },
          {
            'title': 'Superbike Night City',
            'platform': 'Leonardo AI',
            'description': 'Turn your bike into a neon beast',
            'text': 'Recreate this bike as a high-performance superbike. Add glowing LED strips along the frame and neon wheel rims. The setting is a rainy neon street at night with light trails. Cool and futuristic atmosphere. High resolution.',
          },
          {
            'title': 'Vintage Cafe Racer',
            'platform': 'DALL-E 3',
            'description': 'Convert your bike to a retro classic',
            'text': 'Transform this motorcycle into a custom 1970s Cafe Racer. Add a leather seat, chrome details, and a round headlight. The background is a trendy urban brick-wall alley. Hipster aesthetic, soft natural lighting.',
          },
          {
            'title': 'The Royal Bullet Look',
            'platform': 'Midjourney',
            'description': 'The classic Indian Enfield vibe',
            'text': 'Modify this bike photo to look like a premium Royal Enfield Bullet. Add heavy chrome, a mahogany brown seat, and a traditional Indian flag on the front. The background is a nostalgic rural Indian village road during golden hour.',
          },
          {
            'title': 'MotoGP Track Hero',
            'platform': 'Stable Diffusion XL',
            'description': 'You as a professional racer',
            'text': 'Recreate this motorcycle photo on a professional racing circuit. The rider should be leaning low into a turn. Add knee-down action and heat haze coming off the track. Intense, high-speed sports photography style.',
          },
          {
            'title': 'Off-Road Dirt King',
            'platform': 'Leonardo AI',
            'description': 'Add a muddy off-road vibe',
            'text': 'Transform this bike into a rugged off-road machine. Add realistic mud splashes on the body and thick knobby tires. The person is jumping the bike over a dirt mound. Energetic action shot, bright sunlight, forest background.',
          },
          {
            'title': 'Sunset Coastal Ride',
            'platform': 'Midjourney',
            'description': 'A beautiful romantic bike trip',
            'text': 'Place the bike and rider on a scenic coastal highway during a vibrant purple sunset. The ocean is visible on the side. Warm golden light reflecting off the bike’s chrome. Peaceful and inspiring travel photography.',
          },
          {
            'title': 'Ghost Rider Flame Effect',
            'platform': 'DALL-E 3',
            'description': 'Add realistic fire to your bike',
            'text': 'Modify this motorcycle photo to have a supernatural theme. Add realistic flames coming out of the exhaust and wheels. The rider should look like a dark hero. Dark night background with embers flying. Cinematic movie effect.',
          },
          {
            'title': 'Custom Bobber Style',
            'platform': 'Leonardo AI',
            'description': 'A low and mean custom makeover',
            'text': 'Transform this motorcycle into a low-slung custom Bobber. Add a wide rear tire and an aggressive matte black paint job. The background is a dark industrial garage with a single spotlight. Mean and powerful look.',
          },
          {
            'title': 'Modern Urban Scooter',
            'platform': 'Flux AI',
            'description': 'A clean and trendy city vibe',
            'text': 'Convert this scooter photo into a trendy urban lifestyle shot. Bright pastel colors, minimalist city background, and soft morning light. The person should look stylish and approachable. Very clean and high-quality.',
          },
        ];

      case 'Travel India':
        return [
          {
            'title': 'Varanasi Ghat Aarti',
            'platform': 'Midjourney',
            'description': 'Place yourself in a spiritual scene',
            'text': 'Transform this photo to show the person at the Varanasi Ghats during the evening Ganga Aarti. Background includes thousands of glowing diyas in the river and ancient temples. Warm, spiritual atmosphere. Maintain the exact face.',
          },
          {
            'title': 'Pink City Palace',
            'platform': 'Leonardo AI',
            'description': 'See yourself in royal Jaipur',
            'text': 'Take the person from this photo and place them on a balcony overlooking the Hawa Mahal in Jaipur. The person should be in elegant ethnic wear. Soft morning sunlight and a vibrant pink city background. High resolution.',
          },
          {
            'title': 'Munnar Tea Gardens',
            'platform': 'DALL-E 3',
            'description': 'A fresh green Kerala makeover',
            'text': 'Recreate this photo showing the person standing in the middle of the endless rolling green hills of Munnar tea gardens. Add a light morning mist and soft sunlight. Fresh and natural atmosphere. Maintain the original face.',
          },
          {
            'title': 'Taj Mahal Morning',
            'platform': 'Midjourney',
            'description': 'The ultimate Indian travel shot',
            'text': 'Modify this photo to show the person in front of the Taj Mahal during a golden sunrise. No crowds, just the person and the monument. Perfect reflection in the water. Cinematic, world-class travel photography. Maintain the face.',
          },
          {
            'title': 'Goa Beach Party',
            'platform': 'Stable Diffusion XL',
            'description': 'Add a fun tropical vibe',
            'text': 'Transform this photo to show the person at a vibrant beach club in Goa. Add palm trees, a colorful sunset sky, and a chilled holiday vibe. The person should be wearing stylish summer clothes. Vibrant and energetic.',
          },
          {
            'title': 'Ladakh Monastery Peace',
            'platform': 'Leonardo AI',
            'description': 'A high-altitude spiritual theme',
            'text': 'Place the person from this photo at a majestic Buddhist monastery in Ladakh. Background features prayer flags and giant snow-capped mountains. The person should have a peaceful expression. Authentic travel photography style.',
          },
          {
            'title': 'Kerala Houseboat Stay',
            'platform': 'Midjourney',
            'description': 'Relax on the backwaters',
            'text': 'Modify this photo to show the person relaxing on a traditional luxury houseboat in the Kerala backwaters. Surround them with coconut trees and calm water reflections. Warm tropical evening light. Maintain the face.',
          },
          {
            'title': 'Jaisalmer Desert Night',
            'platform': 'DALL-E 3',
            'description': 'Camp under the stars in Rajasthan',
            'text': 'Take the person from this photo and place them by a campfire in the Thar Desert at night. The sky should be filled with a spectacular Milky Way galaxy. Sand dunes and a traditional tent in the background. Maintain the face.',
          },
          {
            'title': 'Mumbai Marine Drive',
            'platform': 'Leonardo AI',
            'description': 'The iconic Queen’s Necklace view',
            'text': 'Recreate this photo showing the person at Marine Drive in Mumbai at night. The city lights curve like a necklace in the background. A light sea breeze effect. Modern urban Indian vibe. Maintain the person’s identity.',
          },
          {
            'title': 'Rishikesh Yoga Dawn',
            'platform': 'Flux AI',
            'description': 'A peaceful wellness transformation',
            'text': 'Transform this photo to show the person performing yoga on the banks of the Ganges in Rishikesh. Background features the river and green hills. Soft, hopeful dawn lighting. Spiritual and healthy vibe. Maintain face.',
          },
        ];

      case 'World Travel':
        return [
          {
            'title': 'Paris Eiffel Sunset',
            'platform': 'Midjourney',
            'description': 'The most romantic travel shot',
            'text': 'Transform this photo to show the person in Paris with the Eiffel Tower in the background during a pink sunset. Change their outfit to an elegant Parisian style. Soft bokeh and warm cinematic lighting. Maintain the exact face.',
          },
          {
            'title': 'New York Times Square',
            'platform': 'Leonardo AI',
            'description': 'Feel the energy of the Big Apple',
            'text': 'Recreate this photo showing the person in the middle of Times Square, New York, at night. Surround them with massive glowing billboards and yellow taxis. Vibrant, fast-paced urban atmosphere. Maintain the original face.',
          },
          {
            'title': 'Santorini White & Blue',
            'platform': 'DALL-E 3',
            'description': 'The iconic Greek Island look',
            'text': 'Take the person from this photo and place them on a white balcony in Santorini overlooking the deep blue Aegean sea. Add the iconic blue domes in the background. Bright, hot Mediterranean sunlight. Maintain face features.',
          },
          {
            'title': 'Tokyo Neon Street',
            'platform': 'Midjourney',
            'description': 'A futuristic Japanese makeover',
            'text': 'Modify this photo to show the person walking through a neon-lit street in Shinjuku, Tokyo. Add rain reflections on the ground and colorful Japanese signs. Cyberpunk street-style photography. Maintain the face identity.',
          },
          {
            'title': 'Swiss Alps Winter',
            'platform': 'Stable Diffusion XL',
            'description': 'A luxury snow holiday theme',
            'text': 'Transform this photo into a winter wonderland. Place the person in the Swiss Alps, surrounded by deep snow and wooden cabins. The person should be wearing a premium winter jacket. Crisp, cold morning lighting. Maintain face.',
          },
          {
            'title': 'London Big Ben Walk',
            'platform': 'Leonardo AI',
            'description': 'A classic European city shot',
            'text': 'Place the person from this photo on a bridge in London with Big Ben and the red buses in the background. Moody British weather with soft light. Elegant and timeless travel photography style. Maintain the unrecognizable face.',
          },
          {
            'title': 'Dubai Burj Khalifa View',
            'platform': 'Midjourney',
            'description': 'A luxury metropolitan makeover',
            'text': 'Modify this photo to show the person on a high-end rooftop in Dubai with the Burj Khalifa towering in the background. Sunset lighting reflecting off glass skyscrapers. Ultra-modern and wealthy vibe. Maintain the original face.',
          },
          {
            'title': 'Bali Jungle Swing',
            'platform': 'DALL-E 3',
            'description': 'The ultimate Instagram travel hook',
            'text': 'Take the person from this photo and place them on a giant swing over a lush tropical jungle valley in Bali. Flowing dress effect and bright tropical sunlight. Adventurous and aesthetic. Maintain the person’s identity.',
          },
          {
            'title': 'Venice Canal Gondola',
            'platform': 'Leonardo AI',
            'description': 'A romantic water-city theme',
            'text': 'Recreate this photo showing the person on a traditional Gondola in the canals of Venice. Background features ancient Italian architecture and small bridges. Soft afternoon light. Romantic and cultural. Maintain face.',
          },
          {
            'title': 'Iceland Northern Lights',
            'platform': 'Flux AI',
            'description': 'A magical cosmic travel look',
            'text': 'Convert this photo to show the person in Iceland under a spectacular Aurora Borealis. The green lights should reflect on the person’s face. Snowy volcanic landscape background. Epic and magical. Maintain the face.',
          },
        ];

      case 'Adventure':
        return [
          {
            'title': 'Skydiving Freefall',
            'platform': 'Midjourney',
            'description': 'See yourself jumping from a plane',
            'text': 'Transform this photo to show the person in a skydiving freefall. Add goggles and a jumpsuit. The background is a breathtaking aerial view of the earth from 10,000 feet. Intense wind effect on hair and clothes. Maintain the exact face.',
          },
          {
            'title': 'Deep Sea Scuba Dive',
            'platform': 'Leonardo AI',
            'description': 'An immersive underwater adventure',
            'text': 'Recreate this photo showing the person as a scuba diver deep underwater. Add a diving mask, air tank, and bubbles. Background is a vibrant coral reef with a shark in the distance. Blue aquatic lighting. Maintain the original face.',
          },
          {
            'title': 'Desert Dune Bashing',
            'platform': 'DALL-E 3',
            'description': 'High-action desert adventure',
            'text': 'Take the person from this photo and place them inside an open-top 4x4 jeep racing over sand dunes in Dubai. Add sand spray and a sense of extreme motion. Bright hot sunlight. The person should look thrilled. Maintain face features.',
          },
          {
            'title': 'Mount Everest Basecamp',
            'platform': 'Midjourney',
            'description': 'The ultimate trekking achievement',
            'text': 'Modify this photo to show the person at Everest Basecamp. Add heavy expedition gear, oxygen mask hanging around neck, and the massive Khumbu icefall in the background. Realistic snow and ice textures. Maintain face identity.',
          },
          {
            'title': 'Rock Climbing Pro',
            'platform': 'Stable Diffusion XL',
            'description': 'A tough and athletic makeover',
            'text': 'Transform this photo to show the person hanging off a sheer rock cliff. Add climbing ropes, chalk on hands, and a focused expression. The background is a vast canyon. High-action sports photography. Maintain face.',
          },
          {
            'title': 'White Water Rafting',
            'platform': 'Leonardo AI',
            'description': 'Feel the splash of the rapids',
            'text': 'Place the person from this photo in a rafting boat on a wild river. Add massive water splashes hitting the person. They should be wearing a helmet and life jacket. High-speed action shot. Maintain the recognizable face.',
          },
          {
            'title': 'African Safari Jeep',
            'platform': 'Midjourney',
            'description': 'A wild wildlife adventure',
            'text': 'Modify this photo to show the person in an open safari jeep in the Savannah. A giant male lion is visible in the background. The person should be holding binoculars. Warm African sunset light. Maintain the original face.',
          },
          {
            'title': 'Bungee Jump Drop',
            'platform': 'DALL-E 3',
            'description': 'Capture the thrill of the fall',
            'text': 'Take the person from this photo and show them in the middle of a bungee jump, falling headfirst towards a river. Add an elastic cord and an expression of pure adrenaline. Dramatic wide-angle shot. Maintain the person’s identity.',
          },
          {
            'title': 'Arctic Dog Sledding',
            'platform': 'Leonardo AI',
            'description': 'A unique frozen adventure',
            'text': 'Recreate this photo showing the person driving a dog sled pulled by Huskies through a frozen arctic landscape. Add heavy fur clothing and flying snow. Cold blue atmosphere. Adventurous and unique. Maintain face.',
          },
          {
            'title': 'Volcano Edge Trek',
            'platform': 'Flux AI',
            'description': 'An epic elemental adventure',
            'text': 'Convert this photo to show the person standing at the very edge of an active volcano crater with glowing lava below. Dramatic smoke and ash in the air. Intense orange heat lighting on the person. Maintain the face.',
          },
        ];

      case 'Hotels Resorts':
        return [
          {
            'title': 'Infinity Pool Sunset',
            'platform': 'Midjourney',
            'description': 'The ultimate luxury lifestyle shot',
            'text': 'Transform this photo to show the person in a luxury infinity pool that merges with the ocean. Set the background to a spectacular sunset sky. The person should be holding a tropical cocktail. 8k high-end resort photography.',
          },
          {
            'title': 'Maldives Overwater Villa',
            'platform': 'Leonardo AI',
            'description': 'See yourself in a paradise room',
            'text': 'Recreate this photo showing the person on the wooden deck of a luxury overwater villa in the Maldives. Crystal clear turquoise water below and a hammock nearby. Bright, airy, and expensive atmosphere. Maintain face.',
          },
          {
            'title': 'Breakfast on the Balcony',
            'platform': 'DALL-E 3',
            'description': 'A trendy "Travel Influencer" look',
            'text': 'Take the person from this photo and place them at a lavish breakfast table on a balcony overlooking the Eiffel Tower or the Swiss Alps. Add fresh fruits, croissants, and coffee. Soft morning light. Maintain face features.',
          },
          {
            'title': 'Royal Palace Suite',
            'platform': 'Midjourney',
            'description': 'Live like a King/Queen in India',
            'text': 'Modify this photo to show the person inside a grand royal suite of a Rajasthani palace hotel. Add gold leaf carvings, silk curtains, and a four-poster bed. Opulent and majestic lighting. Maintain face identity.',
          },
          {
            'title': 'Glass Igloo Northern Lights',
            'platform': 'Stable Diffusion XL',
            'description': 'A cozy and unique luxury stay',
            'text': 'Transform this photo into a luxury glass igloo in Finland. The person is lying on a bed looking up at the Northern Lights through the glass ceiling. Cozy blankets and warm indoor glow. Maintain the face.',
          },
          {
            'title': 'Underwater Resort Room',
            'platform': 'Leonardo AI',
            'description': 'A surreal 5-star experience',
            'text': 'Place the person from this photo inside a luxury underwater hotel room. Sharks and tropical fish are swimming outside the glass walls. Deep blue ambient lighting. High-tech and ultra-luxury vibe. Maintain the face.',
          },
          {
            'title': 'Luxury Safari Glamping',
            'platform': 'Midjourney',
            'description': 'Combine nature and high-end living',
            'text': 'Modify this photo to show the person at a high-end glamping tent in the African wilderness. Add a luxury bathtub outdoors and a view of elephants in the distance. Sophisticated rustic aesthetic. Maintain the original face.',
          },
          {
            'title': 'Private Jet Interior',
            'platform': 'DALL-E 3',
            'description': 'The ultimate sign of success',
            'text': 'Take the person from this photo and place them in a wide, comfortable leather seat inside a private jet. Add a window view of clouds and a glass of champagne. Professional corporate-success photography style. Maintain face.',
          },
          {
            'title': 'Rooftop Helipad Arrival',
            'platform': 'Leonardo AI',
            'description': 'Arrive in style at your hotel',
            'text': 'Recreate this photo showing the person stepping off a helicopter onto a skyscraper helipad. A luxury hotel entrance is visible. Wind effect on clothes and a powerful, wealthy atmosphere. Maintain the recognizable face.',
          },
          {
            'title': 'Forest Treehouse Spa',
            'platform': 'Flux AI',
            'description': 'A peaceful wellness resort theme',
            'text': 'Convert this photo to show the person at a luxury treehouse spa deep in a tropical forest. Add a stone soaking tub with flower petals. Serene, natural, and expensive wellness vibe. Maintain the face identity.',
          },
        ];

      default:
        return [];
    }
  }
}
