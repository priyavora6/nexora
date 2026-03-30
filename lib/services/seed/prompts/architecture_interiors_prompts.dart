class ArchitectureInteriorsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Luxury Penthouse':
        return [
          {'title': 'NYC Skyline Night', 'platform': 'Midjourney', 'description': 'Luxury night life', 'text': 'A person standing in a high-end New York penthouse, floor-to-ceiling windows, Manhattan skyline at night background, modern velvet sofa, warm ambient lighting, rich lifestyle photography'},
          {'title': 'Morning Sun Loft', 'platform': 'DALL-E 3', 'description': 'Bright minimalist morning', 'text': 'A person sitting on a white modern sofa in a sun-drenched penthouse, high ceilings, large plants, view of a coastal city, bright airy aesthetic, architectural digest style'},
          {'title': 'Dark Marble Luxury', 'platform': 'Leonardo AI', 'description': 'Moody expensive interior', 'text': 'A person in a luxury penthouse with black marble floors and gold accents, drinking coffee, dark moody lighting with warm spotlights, cinematic interior design photography'},
          {'title': 'Dubai View Infinity', 'platform': 'Flux AI', 'description': 'Extreme luxury view', 'text': 'A person on a penthouse balcony overlooking the Burj Khalifa, infinity pool edge, sunset sky, luxury summer wear, high-end travel lifestyle vibe'},
          {'title': 'Minimalist Zen Suite', 'platform': 'Stable Diffusion XL', 'description': 'Peaceful luxury living', 'text': 'A person relaxing in a Japanese-style luxury penthouse, wooden slats, bonsai trees, low furniture, view of Mt Fuji through window, soft natural lighting'},
          {'title': 'Champagne Celebration', 'platform': 'Gemini AI', 'description': 'Penthouse party vibes', 'text': 'A person holding a glass of champagne in a crowded luxury penthouse party, bokeh city lights background, glamorous outfit, warm party lighting, professional event photography'},
          {'title': 'Library Retreat', 'platform': 'Adobe Firefly', 'description': 'Two-story private library', 'text': 'A person in a two-story private penthouse library, spiral staircase, massive bookshelves, warm fireplace, cozy but extremely expensive interior design'},
          {'title': 'Ultra-Modern Kitchen', 'platform': 'Midjourney', 'description': 'High-tech kitchen life', 'text': 'A person in a futuristic luxury kitchen, sleek silver island, smart appliances, pouring wine, soft blue ambient light, architectural visualization quality'},
          {'title': 'Rainy Day Glass House', 'platform': 'DALL-E 3', 'description': 'Moody rain window view', 'text': 'A person wrapped in a blanket looking at rain through a massive penthouse window, foggy city background, cozy interior, soft moody lighting, 8k resolution'},
          {'title': 'Golden Hour Lounge', 'platform': 'Leonardo AI', 'description': 'Warm sunset interior', 'text': 'A person lounging in a circular designer chair, golden hour sun hitting the face, luxury penthouse with art-deco style, long shadows, beautiful aesthetic photography'},
        ];

      case 'Executive Office':
        return [
          {'title': 'The CEO Desk', 'platform': 'Midjourney', 'description': 'Powerful executive portrait', 'text': 'A person sitting behind a massive walnut desk in a CEO office, leather chair, panoramic city view, bookshelves, high-end professional atmosphere, corporate photography style'},
          {'title': 'Modern Tech Office', 'platform': 'DALL-E 3', 'description': 'Silicon Valley executive', 'text': 'A person in a modern tech company office, glass walls, white minimalist furniture, multiple monitors, standing and looking at a digital whiteboard, bright professional lighting'},
          {'title': 'Classic Law Firm', 'platform': 'Leonardo AI', 'description': 'Traditional professional style', 'text': 'A person in a classic mahogany-panelled law office, green desk lamp, rows of law books, wearing a sharp suit, warm professional lighting, serious and powerful vibe'},
          {'title': 'The Creative Director', 'platform': 'Flux AI', 'description': 'Artistic office space', 'text': 'A person in a creative studio office, brick walls, mood boards, large windows, leaning against a desk, casual but professional, artistic vibe, natural sunlight'},
          {'title': 'Late Night Founder', 'platform': 'Stable Diffusion XL', 'description': 'Hardworking startup vibe', 'text': 'A person working late in a glass office, dark outside with city lights, desk lamp illuminating the face, empty coffee cups, determined expression, cinematic moody lighting'},
          {'title': 'Sky-High Meeting Room', 'platform': 'Gemini AI', 'description': 'Boardroom leader', 'text': 'A person at the head of a long glass boardroom table, skyscraper view, corporate luxury, professional posture, sharp focus, magazine quality photography'},
          {'title': 'Minimalist Home Office', 'platform': 'Adobe Firefly', 'description': 'Perfect WFH setup', 'text': 'A person in a clean Scandinavian home office, light wood desk, plants, soft morning light, aesthetic and organized, Pinterest style professional photography'},
          {'title': 'The Fashion Editor', 'platform': 'Midjourney', 'description': 'Stylish office recreation', 'text': 'A person in a stylish fashion office, clothing racks in background, designer furniture, bright fashion lighting, chic and professional, Vogue office aesthetic'},
          {'title': 'Global Business Hub', 'platform': 'DALL-E 3', 'description': 'International airport lounge office', 'text': 'A person in a luxury airport executive lounge office, viewing planes on runway, futuristic design, business travel lifestyle, sharp and clean lighting'},
          {'title': 'AIA Architect Studio', 'platform': 'Leonardo AI', 'description': 'Design and blueprint office', 'text': 'A person at a drafting table, blueprints, architectural models in background, wearing glasses, soft creative lighting, intellectual and professional atmosphere'},
        ];

      case 'Dream Home Life':
        return [
          {'title': 'Cozy Living Room', 'platform': 'Midjourney', 'description': 'Soft aesthetic home', 'text': 'A person relaxing on a soft cream sofa, aesthetic pillows, indoor plants, soft natural light through large windows, minimalist modern home interior, peaceful atmosphere'},
          {'title': 'Sunday Morning Coffee', 'platform': 'DALL-E 3', 'description': 'Bright kitchen vibes', 'text': 'A person in a bright white kitchen, marble countertops, making coffee, sun streaming in, fresh flowers, clean and organized home lifestyle photography'},
          {'title': 'Home Theatre Night', 'platform': 'Leonardo AI', 'description': 'Luxury entertainment', 'text': 'A person in a private home cinema, large screen, popcorn, dim LED blue lighting, plush reclining chairs, high-end home lifestyle, cozy movie night'},
          {'title': 'Modern Fireplace Vibe', 'platform': 'Flux AI', 'description': 'Warm winter home', 'text': 'A person sitting by a modern sleek fireplace, reading a book, warm glow, wooden walls, large glass window showing snow outside, hygge lifestyle'},
          {'title': 'Indoor Garden Oasis', 'platform': 'Stable Diffusion XL', 'description': 'Nature inside home', 'text': 'A person tending to plants in an indoor vertical garden, glass ceiling, sunlight, modern white architecture, peaceful and green home interior'},
          {'title': 'Designer Bedroom', 'platform': 'Gemini AI', 'description': 'Aesthetic sleep space', 'text': 'A person waking up in a designer bedroom, high thread-count linens, soft morning light, minimalist furniture, Pinterest-worthy home aesthetic'},
          {'title': 'Smart Home Living', 'platform': 'Adobe Firefly', 'description': 'High-tech domesticity', 'text': 'A person using a holographic smart home panel, ultra-modern white interior, sleek lines, ambient lighting, futuristic home lifestyle'},
          {'title': 'Artistic Dining Room', 'platform': 'Midjourney', 'description': 'Elegant dinner setting', 'text': 'A person at a modern dining table, designer lighting, art on walls, soft evening light, sophisticated and stylish home lifestyle'},
          {'title': 'Bohemian Home Studio', 'platform': 'DALL-E 3', 'description': 'Creative living space', 'text': 'A person in a boho-style home, macrame wall art, lots of plants, sunlight, relaxed and creative home atmosphere, warm colors'},
          {'title': 'Sunset Balcony Life', 'platform': 'Leonardo AI', 'description': 'Outdoor home relaxation', 'text': 'A person sitting on a small aesthetic balcony, fairy lights, sunset view, city background, cozy home vibes, relaxation photography'},
        ];

      case 'Vintage Royal Hall':
        return [
          {'title': 'The Grand Ballroom', 'platform': 'Midjourney', 'description': 'Royal palace interior', 'text': 'A person in a grand royal ballroom, massive crystal chandeliers, gold leaf ornaments on walls, marble floors, wearing formal attire, majestic and opulent atmosphere'},
          {'title': 'Palace Library', 'platform': 'DALL-E 3', 'description': 'Old world luxury', 'text': 'A person in a vintage royal library, towering wooden shelves, leather books, rolling ladders, warm lamp light, historical and intellectual royal vibe'},
          {'title': 'Throne Room Presence', 'platform': 'Leonardo AI', 'description': 'Majestic leadership', 'text': 'A person standing near a grand throne, red velvet curtains, sunlight through stained glass, historical royal architecture, powerful and majestic stance'},
          {'title': 'Royal Dining Hall', 'platform': 'Flux AI', 'description': 'Classical banquet style', 'text': 'A person at a long royal dining table, silver candelabras, antique portraits on walls, high ceilings, dramatic classical lighting, museum quality architecture'},
          {'title': 'Staircase of Kings', 'platform': 'Stable Diffusion XL', 'description': 'Grand architectural entry', 'text': 'A person walking down a massive sweeping marble staircase, ornate railings, palace entrance, grand and elegant perspective, royal lifestyle'},
          {'title': 'The Music Room', 'platform': 'Gemini AI', 'description': 'Classical royal arts', 'text': 'A person at a grand piano in a royal music hall, oil paintings on walls, silk curtains, soft afternoon sun, elegant and cultural royal interior'},
          {'title': 'Garden Palace Archway', 'platform': 'Adobe Firefly', 'description': 'Outdoor royal architecture', 'text': 'A person standing under a grand white marble archway, royal garden in background, intricate carvings, bright sunny day, majestic architectural photography'},
          {'title': 'The Bedchamber', 'platform': 'Midjourney', 'description': 'Vintage royal rest', 'text': 'A person in a royal vintage bedroom, canopy bed, antique furniture, soft warm lighting, opulent and historical interior design'},
          {'title': 'Private Study Room', 'platform': 'DALL-E 3', 'description': 'Royal workstation', 'text': 'A person in a royal study, writing on parchment, old maps on walls, dark wood textures, warm fire glow, historical and scholarly atmosphere'},
          {'title': 'Palace Courtyard', 'platform': 'Leonardo AI', 'description': 'Majestic open space', 'text': 'A person in a symmetric royal courtyard, fountains, arches, white stone, clear blue sky, majestic and serene architectural view'},
        ];

      case 'Creative Studio':
        return [
          {'title': 'Industrial Art Loft', 'platform': 'Midjourney', 'description': 'Modern creative space', 'text': 'A person in a large industrial art loft, brick walls, paint splatters on floor, massive canvases, natural light from high windows, creative and messy studio vibe'},
          {'title': 'Photographers Studio', 'platform': 'DALL-E 3', 'description': 'Professional media space', 'text': 'A person in a professional photography studio, white cyclorama wall, softboxes, cameras, modern tech, bright clean professional lighting'},
          {'title': 'Fashion Design Atelier', 'platform': 'Leonardo AI', 'description': 'Stylish workspace', 'text': 'A person in a fashion design studio, mannequins, fabrics, sewing machines, mood boards on wall, stylish and creative workspace'},
          {'title': 'Modern Music Studio', 'platform': 'Flux AI', 'description': 'Audio production room', 'text': 'A person in a high-end music studio, synthesizers, soundproofing foam on walls, glowing monitors, neon accents, professional audio-tech vibe'},
          {'title': 'Architects Drafting Room', 'platform': 'Stable Diffusion XL', 'description': 'Design and blueprinting', 'text': 'A person at a drafting table, blueprints, architectural models, rulers and pens, bright overhead lighting, focused and creative atmosphere'},
          {'title': 'Pottery & Clay Studio', 'platform': 'Gemini AI', 'description': 'Handcrafted art space', 'text': 'A person at a pottery wheel, clay on hands, shelves of ceramics, rustic wooden interior, warm natural light, organic and creative studio'},
          {'title': 'Graphic Design Hub', 'platform': 'Adobe Firefly', 'description': 'Digital creative office', 'text': 'A person at a clean white desk, large tablet and stylus, sleek monitors, minimal plants, bright professional digital art studio'},
          {'title': 'Filmmakers Edit Suite', 'platform': 'Midjourney', 'description': 'Video production life', 'text': 'A person in a dark editing room, multiple screens showing video timelines, glowing buttons, professional post-production atmosphere'},
          {'title': 'Sculptors Workshop', 'platform': 'DALL-E 3', 'description': 'Stone and metal art', 'text': 'A person with a chisel, stone dust in air, large sculptures in progress, industrial lighting, creative and physical art space'},
          {'title': 'Plantsman Studio', 'platform': 'Leonardo AI', 'description': 'Botanical creative room', 'text': 'A person in a botanical studio, thousands of plants, glass roof, watering cans, sunlight, lush and green creative workspace'},
        ];

      case 'Outdoor Balcony':
        return [
          {'title': 'Sunset Terrace Garden', 'platform': 'Midjourney', 'description': 'High-end outdoor life', 'text': 'A person on a luxury rooftop terrace at sunset, infinity pool edge, modern lounge chairs, city skyline in background, golden hour lighting, rich travel lifestyle'},
          {'title': 'Minimalist Balcony View', 'platform': 'DALL-E 3', 'description': 'Clean urban escape', 'text': 'A person on a white minimalist balcony, glass railings, overlooking a modern city, single designer chair, bright morning light, peaceful and high-end'},
          {'title': 'Tropical Balcony Vibes', 'platform': 'Leonardo AI', 'description': 'Resort style living', 'text': 'A person on a wooden balcony, tropical plants, ocean view, hammock, bright sunny day, vacation and resort lifestyle photography'},
          {'title': 'Rainy Glass Balcony', 'platform': 'Flux AI', 'description': 'Moody outdoor space', 'text': 'A person standing on a glass-enclosed balcony during rain, city lights blurred outside, cozy sweater, soft moody blue lighting, cinematic atmosphere'},
          {'title': 'Parisian Balcony', 'platform': 'Stable Diffusion XL', 'description': 'Classic European style', 'text': 'A person on a small ornate iron balcony, view of the Eiffel Tower, coffee and croissant on table, morning sunlight, classic and romantic architecture'},
          {'title': 'Luxury Firepit Terrace', 'platform': 'Gemini AI', 'description': 'Night time outdoor luxury', 'text': 'A person sitting by a modern gas firepit on a rooftop terrace, night sky, city lights, cozy blankets, warm fire glow against dark sky'},
          {'title': 'Jungle Balcony Retreat', 'platform': 'Adobe Firefly', 'description': 'Nature immersed living', 'text': 'A person on a balcony surrounded by deep jungle greenery, mist in the trees, wooden architecture, tranquil and natural outdoor space'},
          {'title': 'Skyscraper Balcony Yoga', 'platform': 'Midjourney', 'description': 'Wellness in the sky', 'text': 'A person doing yoga on a high-altitude balcony, sunrise background, modern city architecture, peaceful and healthy lifestyle photography'},
          {'title': 'Modern Breakfast Balcony', 'platform': 'DALL-E 3', 'description': 'Aesthetic morning meal', 'text': 'A person having breakfast on a stylish balcony, marble table, fruit and flowers, bright sunny morning, aesthetic and clean lifestyle'},
          {'title': 'Mediterranean Balcony', 'platform': 'Leonardo AI', 'description': 'Sea-side luxury', 'text': 'A person on a white stone balcony, blue ocean background, bougainvillea flowers, bright Mediterranean sun, vibrant and luxury holiday vibe'},
        ];

      default:
        return [];
    }
  }
}