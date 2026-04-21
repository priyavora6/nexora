// lib/services/seed/prompts/art_styles_prompts.dart

class ArtStylesPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Photorealistic':
        return [
          {'title': 'Hyper Real Portrait', 'platform': 'Midjourney', 'description': 'Ultra realistic human portrait', 'text': 'Hyper realistic portrait of Indian woman, every pore and hair strand visible, natural skin texture, studio lighting, sharp focus on eyes, photorealistic digital art indistinguishable from photograph'},
          {'title': 'Realistic Street Scene', 'platform': 'DALL-E 3', 'description': 'Photo-real city street', 'text': 'Photorealistic Mumbai street scene after rain, wet reflections on road, auto rickshaws and people, puddles reflecting neon signs, evening golden hour, looks like real photograph'},
          {'title': 'Real Food Photography', 'platform': 'Leonardo AI', 'description': 'Hyper realistic food', 'text': 'Hyper realistic butter chicken dish, steam rising, perfect naan beside, every spice particle visible, restaurant table setting, food photography indistinguishable from real'},
          {'title': 'Realistic Animal Portrait', 'platform': 'Stable Diffusion XL', 'description': 'Photo-real animal close-up', 'text': 'Photorealistic Bengal tiger close-up portrait, every whisker and fur strand visible, intense amber eyes, jungle background, wildlife photography quality'},
          {'title': 'Real Interior Design', 'platform': 'Gemini AI', 'description': 'Photo-real room design', 'text': 'Photorealistic modern Indian living room interior, sunlight streaming through curtains, realistic furniture textures, potted plants, looks like real interior photograph'},
          {'title': 'Realistic Car Render', 'platform': 'Adobe Firefly', 'description': 'Photo-real vehicle', 'text': 'Hyper realistic sports car on mountain road, perfect paint reflections, realistic tire tread detail, dramatic lighting, automotive photography quality render'},
          {'title': 'Real Landscape Scene', 'platform': 'Midjourney', 'description': 'Photo-real nature', 'text': 'Photorealistic Himalayan mountain landscape, snow-capped peaks, realistic cloud formations, pine forest below, crystal clear river, looks like National Geographic photograph'},
          {'title': 'Realistic Product Render', 'platform': 'Flux AI', 'description': 'Photo-real product shot', 'text': 'Hyper realistic product render of luxury watch, every metal surface reflection accurate, glass crystal transparency, realistic leather strap texture, commercial photography quality'},
          {'title': 'Real Water Droplets', 'platform': 'DALL-E 3', 'description': 'Macro water detail', 'text': 'Photorealistic macro shot of water droplets on lotus leaf, perfect surface tension, light refraction in each droplet, green leaf texture, macro photography quality'},
          {'title': 'Realistic Night City', 'platform': 'Leonardo AI', 'description': 'Photo-real cityscape', 'text': 'Photorealistic night cityscape of Delhi, car light trails on road, building lights reflected, realistic atmospheric haze, city night photography quality'},
        ];

      case 'Anime Manga':
        return [
          {'title': 'Anime Warrior Girl', 'platform': 'Midjourney', 'description': 'Japanese anime style warrior', 'text': 'Beautiful anime warrior girl with flowing black hair, traditional Indian armor with modern elements, katana sword, cherry blossom petals falling, Studio Ghibli quality, vibrant anime art style'},
          {'title': 'Manga School Student', 'platform': 'DALL-E 3', 'description': 'Classic manga school scene', 'text': 'Indian manga style school student, big expressive eyes, school uniform, cherry blossom background, classic shoujo manga art style, soft pastel colors'},
          {'title': 'Anime Cyberpunk City', 'platform': 'Leonardo AI', 'description': 'Futuristic anime cityscape', 'text': 'Cyberpunk anime city at night, neon signs in Hindi and Japanese, flying vehicles, rain-soaked streets, Akira and Ghost in Shell inspired, detailed anime background art'},
          {'title': 'Chibi Character Set', 'platform': 'Stable Diffusion XL', 'description': 'Cute chibi style characters', 'text': 'Adorable chibi style Indian characters, big heads small bodies, various expressions and poses, kawaii aesthetic, sticker sheet design, cute anime art'},
          {'title': 'Anime Food Illustration', 'platform': 'Gemini AI', 'description': 'Anime style food art', 'text': 'Beautiful anime style Indian food illustration, steaming biryani plate, sparkle effects, exaggerated delicious look, food manga style, mouth-watering anime food art'},
          {'title': 'Shonen Action Scene', 'platform': 'Adobe Firefly', 'description': 'Action manga panel', 'text': 'Dynamic shonen anime action scene, Indian male hero powering up, energy aura around body, dramatic speed lines, Dragon Ball inspired action pose, manga panel art style'},
          {'title': 'Anime Romantic Sunset', 'platform': 'Midjourney', 'description': 'Romance anime scene', 'text': 'Romantic anime scene, Indian couple at sunset, cherry blossoms falling, soft bokeh lights, Your Name movie inspired atmosphere, beautiful shoujo manga art style'},
          {'title': 'Mecha Robot Design', 'platform': 'Flux AI', 'description': 'Giant robot anime art', 'text': 'Giant mecha robot anime design, Indian inspired ornamental armor, standing in city, dramatic pose, Gundam Evangelion style, detailed mechanical anime art'},
          {'title': 'Anime Portrait Profile', 'platform': 'DALL-E 3', 'description': 'Character portrait art', 'text': 'Detailed anime character portrait, Indian features with anime styling, wind blowing hair, emotional expression, high quality character illustration, anime profile art'},
          {'title': 'Anime Nature Spirit', 'platform': 'Leonardo AI', 'description': 'Fantasy anime creature', 'text': 'Mystical anime forest spirit, inspired by Indian mythology, Ghibli Princess Mononoke style, glowing ethereal being, magical forest, fantasy anime creature design'},
        ];

      case '3D Render':
        return [
          {'title': '3D Character Model', 'platform': 'Midjourney', 'description': 'Pixar style 3D character', 'text': 'Adorable 3D rendered Indian boy character, Pixar movie quality, big expressive eyes, colorful casual clothes, playful pose, clean studio background, professional 3D character art'},
          {'title': '3D Product Mockup', 'platform': 'DALL-E 3', 'description': '3D product visualization', 'text': '3D rendered smartphone mockup floating in space, glass material, reflective surface, soft gradient background, product visualization, professional 3D commercial render'},
          {'title': '3D Room Interior', 'platform': 'Leonardo AI', 'description': 'Isometric room render', 'text': 'Isometric 3D render of modern Indian bedroom, cute miniature style, detailed furniture and decor, warm lighting, architectural visualization, 3D diorama art'},
          {'title': '3D Low Poly Landscape', 'platform': 'Stable Diffusion XL', 'description': 'Low polygon style scene', 'text': 'Beautiful low poly 3D landscape, geometric mountains and trees, simple color palette, sunset sky, minimalist 3D art style, low polygon terrain render'},
          {'title': '3D Logo Render', 'platform': 'Gemini AI', 'description': 'Metallic 3D logo', 'text': '3D rendered metallic gold logo floating in dark space, glossy reflective surface, dramatic spot lighting, professional 3D logo visualization, brand identity render'},
          {'title': '3D Food Render', 'platform': 'Adobe Firefly', 'description': 'Hyper real 3D food', 'text': '3D rendered Indian sweets arrangement, ladoo and barfi with realistic textures, clay render style, turntable product visualization, 3D food illustration'},
          {'title': '3D Architectural Viz', 'platform': 'Midjourney', 'description': 'Building 3D render', 'text': 'Photorealistic 3D architectural visualization, modern Indian villa exterior, landscaped garden, pool, sunset lighting, professional architectural render, real estate visualization'},
          {'title': '3D Abstract Sculpture', 'platform': 'Flux AI', 'description': 'Abstract 3D art', 'text': 'Abstract 3D sculpture render, flowing organic shapes, metallic and glass materials, dynamic lighting with caustics, contemporary digital art, abstract 3D visualization'},
          {'title': '3D Cute Animal', 'platform': 'DALL-E 3', 'description': 'Cartoon 3D animal', 'text': 'Cute 3D rendered baby elephant, Pixar Disney style, big adorable eyes, soft grey skin texture, playful pose, childrens illustration quality, 3D cartoon animal'},
          {'title': '3D Game Asset', 'platform': 'Leonardo AI', 'description': 'Game ready 3D model', 'text': '3D game asset treasure chest, hand-painted texture style, stylized proportions, gems and gold coins, RPG game aesthetic, game ready 3D model render'},
        ];

      case 'Watercolor':
        return [
          {'title': 'Watercolor Taj Mahal', 'platform': 'Midjourney', 'description': 'Taj Mahal watercolor painting', 'text': 'Beautiful watercolor painting of Taj Mahal at sunrise, soft washes of pink and gold, loose brush strokes, artistic water bleeding effects, architectural watercolor art, traditional painting technique'},
          {'title': 'Watercolor Floral', 'platform': 'DALL-E 3', 'description': 'Flower bouquet painting', 'text': 'Delicate watercolor flower bouquet, roses and wildflowers, soft bleeding colors, white paper showing through, loose artistic style, botanical watercolor illustration'},
          {'title': 'Watercolor Portrait', 'platform': 'Leonardo AI', 'description': 'Person in watercolor style', 'text': 'Watercolor portrait of Indian woman, expressive brush strokes, color splashes forming face, artistic dripping effect, loose wet-on-wet technique, contemporary watercolor art'},
          {'title': 'Watercolor Landscape', 'platform': 'Stable Diffusion XL', 'description': 'Nature scene watercolor', 'text': 'Serene watercolor landscape, Kerala backwaters, palm trees and houseboat, soft green and blue washes, atmospheric perspective, traditional watercolor painting'},
          {'title': 'Watercolor Bird', 'platform': 'Gemini AI', 'description': 'Bird watercolor art', 'text': 'Vibrant watercolor painting of Indian kingfisher bird, bright blue and orange colors, splashing water drops, white background, wildlife watercolor illustration'},
          {'title': 'Watercolor Street Scene', 'platform': 'Adobe Firefly', 'description': 'Old city watercolor', 'text': 'Atmospheric watercolor of old Varanasi ghats, temple architecture, morning light on Ganges, warm ochre and blue washes, plein air painting style, urban sketch watercolor'},
          {'title': 'Watercolor Food Art', 'platform': 'Midjourney', 'description': 'Food in watercolor style', 'text': 'Watercolor illustration of Indian chai and samosa, warm brown and golden tones, steam rising artistically, food illustration style, appetizing watercolor food art'},
          {'title': 'Watercolor Tree Seasons', 'platform': 'Flux AI', 'description': 'Four seasons tree painting', 'text': 'Watercolor painting showing single tree in four seasons, spring summer autumn winter, different color palettes, artistic seasonal comparison, nature watercolor art'},
          {'title': 'Watercolor Animal', 'platform': 'DALL-E 3', 'description': 'Animal watercolor painting', 'text': 'Majestic watercolor painting of Indian elephant, grey washes with colorful decorations, loose expressive strokes, artistic dripping effects, wildlife watercolor art'},
          {'title': 'Watercolor Abstract', 'platform': 'Leonardo AI', 'description': 'Abstract watercolor art', 'text': 'Abstract watercolor composition, flowing colors merging and bleeding, wet-on-wet technique, unexpected color combinations, contemporary abstract watercolor art, artistic expression'},
        ];

      case 'Oil Painting':
        return [
          {'title': 'Oil Portrait Classic', 'platform': 'Midjourney', 'description': 'Classical oil portrait', 'text': 'Classical oil portrait of Indian royalty in traditional attire, rich impasto brushwork, dramatic Rembrandt lighting, golden frame worthy, museum quality oil painting, old master technique'},
          {'title': 'Oil Landscape Sunset', 'platform': 'DALL-E 3', 'description': 'Scenic oil painting', 'text': 'Impressionist oil painting of Indian countryside sunset, thick textured brush strokes, warm orange and purple sky, rice paddies in foreground, Monet inspired landscape oil painting'},
          {'title': 'Oil Still Life', 'platform': 'Leonardo AI', 'description': 'Traditional still life', 'text': 'Classic oil painting still life, brass vessels and fruits, Indian mango and banner, dramatic chiaroscuro lighting, rich warm tones, Dutch master style still life painting'},
          {'title': 'Oil Seascape', 'platform': 'Stable Diffusion XL', 'description': 'Ocean oil painting', 'text': 'Dramatic oil painting of Indian ocean coastline, crashing waves on rocks, stormy sky, thick impasto texture in waves, marine oil painting, Turner inspired seascape'},
          {'title': 'Oil Flower Painting', 'platform': 'Gemini AI', 'description': 'Floral oil painting', 'text': 'Beautiful oil painting of lotus flowers, thick textured petals, rich colors on dark background, visible brush strokes, botanical oil painting, impressionist flower art'},
          {'title': 'Oil City Night', 'platform': 'Adobe Firefly', 'description': 'Urban night oil painting', 'text': 'Oil painting of Mumbai city at night, wet streets reflecting lights, thick impasto technique, vibrant neon colors, contemporary urban oil painting'},
          {'title': 'Oil Temple Architecture', 'platform': 'Midjourney', 'description': 'Temple oil painting', 'text': 'Magnificent oil painting of ancient Indian temple, architectural details in thick paint, golden hour lighting, sacred atmosphere, architectural oil painting masterpiece'},
          {'title': 'Oil Abstract Expression', 'platform': 'Flux AI', 'description': 'Abstract expressionist oil', 'text': 'Abstract expressionist oil painting, bold gestural strokes, vibrant Indian colors saffron green white, emotional energy on canvas, contemporary abstract oil art'},
          {'title': 'Oil Village Life', 'platform': 'DALL-E 3', 'description': 'Rural Indian oil painting', 'text': 'Oil painting of Indian village life, farmer with oxen in field, golden wheat harvest, warm rustic colors, realistic rural scene, Indian folk art style oil painting'},
          {'title': 'Oil Self Portrait', 'platform': 'Leonardo AI', 'description': 'Self portrait oil style', 'text': 'Dramatic oil painting self-portrait style, Indian artist looking at viewer, half face in shadow, rich warm skin tones, thick impasto technique, expressive portraiture'},
        ];

      case 'Pixel Art':
        return [
          {'title': 'Pixel Art Cityscape', 'platform': 'Midjourney', 'description': 'Retro pixel city scene', 'text': 'Detailed pixel art Indian cityscape at night, 16-bit style, neon signs and street vendors, auto rickshaws, bustling city atmosphere, retro game aesthetic pixel art'},
          {'title': 'Pixel Character Sprite', 'platform': 'DALL-E 3', 'description': 'Game character pixel art', 'text': 'Pixel art character sprite sheet, Indian warrior character, multiple poses and animations, 32x32 pixel grid, retro game character design, 8-bit pixel art style'},
          {'title': 'Pixel Art Food', 'platform': 'Leonardo AI', 'description': 'Food in pixel style', 'text': 'Adorable pixel art Indian food items, biryani thali samosa chai, cute retro game style, small detailed sprites, 16-bit food pixel art collection'},
          {'title': 'Pixel Landscape Sunset', 'platform': 'Stable Diffusion XL', 'description': 'Scenic pixel art', 'text': 'Beautiful pixel art sunset landscape, mountains and lake, limited color palette, dithering techniques, nostalgic retro aesthetic, scenic pixel art wallpaper'},
          {'title': 'Pixel Art Temple', 'platform': 'Gemini AI', 'description': 'Indian temple pixel art', 'text': 'Pixel art Indian temple, detailed architecture in pixels, warm colors, birds flying, devotees at entrance, cultural pixel art scene, retro game background'},
          {'title': 'Pixel Art Animals', 'platform': 'Adobe Firefly', 'description': 'Cute pixel animals', 'text': 'Cute pixel art Indian animals, elephant tiger peacock cow, adorable small sprites, pastel colors, kawaii pixel style, animal sprite sheet'},
          {'title': 'Pixel Art Room', 'platform': 'Midjourney', 'description': 'Isometric pixel room', 'text': 'Isometric pixel art Indian bedroom, detailed furniture and decor, warm cozy atmosphere, retro gaming aesthetic, isometric room design pixel art'},
          {'title': 'Pixel Art Vehicle', 'platform': 'Flux AI', 'description': 'Retro pixel vehicles', 'text': 'Pixel art Indian vehicles collection, auto rickshaw ambassador car Bullet motorcycle, side view sprites, retro game asset style, vehicle pixel art set'},
          {'title': 'Pixel Art Festival', 'platform': 'DALL-E 3', 'description': 'Festival pixel scene', 'text': 'Pixel art Diwali celebration scene, diyas and fireworks, people celebrating, colorful detailed pixel work, festive atmosphere, cultural pixel art'},
          {'title': 'Pixel Art Portrait', 'platform': 'Leonardo AI', 'description': 'Face in pixel style', 'text': 'Pixel art portrait of Indian person, limited but expressive pixels, recognizable features, clean pixel work, retro avatar style, profile picture pixel art'},
        ];

      default:
        return [];
    }
  }
}
