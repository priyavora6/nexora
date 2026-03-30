// lib/services/seed/prompts/wedding_marriage_prompts.dart

class WeddingMarriagePrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Bridal Portraits':
        return [
          {
            'title': 'Royal Red Lehenga',
            'platform': 'Midjourney',
            'description': 'Traditional red bridal look',
            'text': 'Stunning Indian bride in royal red Sabyasachi lehenga, heavy kundan gold jewelry, intricate embroidery, soft bridal makeup, heritage palace background, natural window lighting, 8k cinematic photography.',
          },
          {
            'title': 'South Indian Silk',
            'platform': 'Leonardo AI',
            'description': 'Traditional silk saree bride',
            'text': 'Beautiful South Indian bride in a rich Kanjeevaram silk saree, temple gold jewelry, jasmine flowers in hair, traditional tilak, temple architecture background, cultural elegance, hyper-realistic.',
          },
          {
            'title': 'Bridal Mirror Reflection',
            'platform': 'DALL-E 3',
            'description': 'Bride looking at herself',
            'text': 'Indian bride looking at her reflection in an ornate vintage mirror, final touch-up of nath, emotional expression, soft warm lighting, blurred dressing room background, professional wedding photography.',
          },
          {
            'title': 'Pastel Modern Bride',
            'platform': 'Stable Diffusion XL',
            'description': 'Modern minimal bridal look',
            'text': 'Modern Indian bride in a pastel pink and mint lehenga, minimal diamond jewelry, contemporary hairstyle, garden setting, soft bokeh, fresh and airy aesthetic, high resolution.',
          },
          {
            'title': 'Bengali Traditional',
            'platform': 'Midjourney',
            'description': 'Classic Bengali bride',
            'text': 'Traditional Bengali bride in red Banarasi saree, mukut crown, white and red bindis on forehead, holding a betel leaf, alta on hands, artistic cultural portrait, 8k.',
          },
          {
            'title': 'Bridal Close-up Eyes',
            'platform': 'Leonardo AI',
            'description': 'Macro shot of bridal makeup',
            'text': 'Macro shot of an Indian bride’s eyes, perfect gold and bronze smokey eye makeup, thick eyelashes, maang tikka visible on forehead, soft skin texture, professional beauty photography.',
          },
          {
            'title': 'Muslim Nikah Look',
            'platform': 'DALL-E 3',
            'description': 'Elegant Nikah bridal attire',
            'text': 'Muslim Indian bride in a gold and emerald green sharara, traditional jhumar on side of head, elegant veil, glowing skin, soft morning light, dignified and graceful portrait.',
          },
          {
            'title': 'Floral Garden Bride',
            'platform': 'Midjourney',
            'description': 'Outdoor floral portrait',
            'text': 'Indian bride standing in a lush garden full of white roses, flowing dupatta in the wind, soft sunlight, ethereal and dreamy atmosphere, fine art wedding photography.',
          },
          {
            'title': 'Bride with Kaleeras',
            'platform': 'Stable Diffusion XL',
            'description': 'Focus on traditional bangles',
            'text': 'Close up of a Punjabi bride’s hands, wearing red chooda and golden kaleeras, intricate mehndi, wedding lehenga texture visible, traditional wedding accessories.',
          },
          {
            'title': 'Emotional Vidai Moment',
            'platform': 'Midjourney',
            'description': 'Candid emotional portrait',
            'text': 'Candid emotional portrait of an Indian bride during her Vidai, a tear rolling down her cheek, soft evening lighting, cinematic and deeply moving, documentary photography style.',
          },
        ];

      case 'Groom Portraits':
        return [
          {
            'title': 'Royal Sherwani Pose',
            'platform': 'Midjourney',
            'description': 'Regal groom portrait',
            'text': 'Handsome Indian groom in a royal ivory sherwani, traditional pagdi turban with emerald kalgi, holding a ceremonial sword, heritage fort background, confident and regal, 8k.',
          },
          {
            'title': 'The Turban Tie',
            'platform': 'DALL-E 3',
            'description': 'Groom tying safa',
            'text': 'Candid shot of an Indian groom getting his safa (turban) tied by elders, mirrors in the background, anticipation on face, traditional wedding ritual, warm home lighting.',
          },
          {
            'title': 'Modern Tuxedo Look',
            'platform': 'Leonardo AI',
            'description': 'Formal reception groom',
            'text': 'Stylish Indian groom in a black velvet tuxedo, bow tie, luxury watch, modern penthouse background with city lights, sophisticated and sharp, editorial fashion photography.',
          },
          {
            'title': 'Groom on Horseback',
            'platform': 'Midjourney',
            'description': 'Traditional Baraat entrance',
            'text': 'Indian groom sitting on a decorated white horse for Baraat, traditional sehra covering face, relatives dancing around, fireworks in the background, festive night atmosphere.',
          },
          {
            'title': 'Bandhgala Elegance',
            'platform': 'Stable Diffusion XL',
            'description': 'Traditional jacket look',
            'text': 'Man in a navy blue Jodhpuri bandhgala jacket, intricate silver buttons, minimalist heritage background, dignified and classic Indian menswear portrait.',
          },
          {
            'title': 'Groom’s Shoes Detail',
            'platform': 'DALL-E 3',
            'description': 'Macro shot of mojari',
            'text': 'Close-up of traditional Indian wedding footwear (Mojaris), gold embroidery on leather, sherwani fabric in the background, luxury product photography style.',
          },
          {
            'title': 'Groom with Brothers',
            'platform': 'Midjourney',
            'description': 'Fun candid with friends',
            'text': 'Indian groom laughing with his groomsmen, everyone in matching ethnic wear, sunny outdoor garden, joyful and energetic, candid friendship photography.',
          },
          {
            'title': 'Sikh Groom Portrait',
            'platform': 'Leonardo AI',
            'description': 'Elegant Sardar groom',
            'text': 'Sikh groom in a peach sherwani and maroon turban, full beard, kirpan in hand, Gurudwara background, spiritual and serene atmosphere, high resolution.',
          },
          {
            'title': 'The Final Adjustment',
            'platform': 'Stable Diffusion XL',
            'description': 'Groom adjusting watch',
            'text': 'Close up of a groom’s hand adjusting a luxury watch, sherwani sleeve with heavy embroidery, expensive perfume bottle nearby, preparation for the wedding day.',
          },
          {
            'title': 'Groom Architectural Pose',
            'platform': 'Midjourney',
            'description': 'Groom in royal arches',
            'text': 'Indian groom standing inside the symmetrical arches of an ancient palace, dramatic shadows, golden sunlight, epic and cinematic scale, professional wedding photography.',
          },
        ];

      case 'Haldi Ceremony':
        return [
          {
            'title': 'Haldi Flower Shower',
            'platform': 'Midjourney',
            'description': 'Petals falling on bride',
            'text': 'Indian bride covered in yellow haldi paste, yellow marigold petals falling from above, laughing, yellow saree, vibrant outdoor setup, joyful and bright, high-speed photography.',
          },
          {
            'title': 'Traditional Haldi Bowl',
            'platform': 'DALL-E 3',
            'description': 'Macro of turmeric paste',
            'text': 'Macro shot of a brass bowl containing yellow haldi paste, rose petals on top, blurred background of wedding guests in yellow, traditional Indian ritual details.',
          },
          {
            'title': 'Playful Groom Haldi',
            'platform': 'Leonardo AI',
            'description': 'Friends applying haldi',
            'text': 'Indian groom being playfully attacked with haldi by his friends, water splashing, yellow stains on white kurta, messy and fun, candid action shot, sunlight.',
          },
          {
            'title': 'Sister Applying Haldi',
            'platform': 'Stable Diffusion XL',
            'description': 'Emotional sibling bond',
            'text': 'Emotional moment of a sister applying haldi paste to her brother’s cheek, traditional yellow decor, intimate family bond, soft warm lighting, cinematic documentary style.',
          },
          {
            'title': 'Yellow Theme Decor',
            'platform': 'Midjourney',
            'description': 'Haldi event setup',
            'text': 'Traditional Indian Haldi ceremony decoration, thousands of yellow marigolds, curtains of flowers, a wooden swing (jhoola) in the center, bright sunny day, aesthetic event photography.',
          },
          {
            'title': 'Haldi Hand Prints',
            'platform': 'DALL-E 3',
            'description': 'Handprints on a wall',
            'text': 'Yellow haldi handprints on a white wall, blurred bride in the background, artistic symbolic shot of Indian wedding traditions, minimalist and meaningful.',
          },
          {
            'title': 'Bride’s Feet Haldi',
            'platform': 'Leonardo AI',
            'description': 'Focus on feet and anklets',
            'text': 'Close up of a bride’s feet being covered in haldi paste, silver anklets, flower petals on the floor, traditional ritual, cultural wedding photography.',
          },
          {
            'title': 'The Haldi Splash',
            'platform': 'Midjourney',
            'description': 'Water bucket splash',
            'text': 'Action shot of a bucket of water being thrown at the groom after the haldi ceremony, frozen water droplets, backlight, pure joy and celebration, high resolution.',
          },
          {
            'title': 'Grandma’s Blessings',
            'platform': 'Stable Diffusion XL',
            'description': 'Elderly ritual candid',
            'text': 'Elderly Indian woman applying haldi to her grandson, wrinkled hands, wise smile, traditional blessings, heartwarming family moment, shallow depth of field.',
          },
          {
            'title': 'Couple Joint Haldi',
            'platform': 'Midjourney',
            'description': 'Joint celebration',
            'text': 'Indian bride and groom sitting together for a joint Haldi ceremony, both covered in yellow, looking at each other, laughing, marigold decor, vibrant and happy atmosphere.',
          },
        ];

      case 'Mehndi Function':
        return [
          {
            'title': 'Intricate Hand Art',
            'platform': 'Midjourney',
            'description': 'Macro mehndi design',
            'text': 'Macro shot of intricate bridal mehndi on hands, peacock and floral patterns, dark henna stain, emerald bangles, silk lehenga background, professional bridal detail photography.',
          },
          {
            'title': 'Bride on Mehndi Swing',
            'platform': 'DALL-E 3',
            'description': 'Colorful mehndi setup',
            'text': 'Indian bride sitting on a floral decorated swing, colorful cushions, Mehndi artists working on her feet, smiling, bright festive lighting, Rajasthani umbrellas in background.',
          },
          {
            'title': 'The Mehndi Artist',
            'platform': 'Leonardo AI',
            'description': 'Focus on the artist',
            'text': 'Mehndi artist carefully drawing a design on a bride’s hand with a cone, extreme focus, artistic hand movements, blurred festive background, cultural art in action.',
          },
          {
            'title': 'Mehndi and Jewels',
            'platform': 'Stable Diffusion XL',
            'description': 'Floral jewelry focus',
            'text': 'Bride wearing yellow and pink floral jewelry, intricate mehndi on hands, looking down shyly, warm evening sun, soft bokeh, aesthetic mehndi portrait.',
          },
          {
            'title': 'Mehndi Feet Patterns',
            'platform': 'Midjourney',
            'description': 'Mehndi on bridal feet',
            'text': 'Intricate mehndi patterns on an Indian bride’s feet, anklets with bells, sitting on a colorful carpet, traditional wedding rituals, high resolution, top-down shot.',
          },
          {
            'title': 'Mother-Daughter Mehndi',
            'platform': 'DALL-E 3',
            'description': 'Emotional family candid',
            'text': 'Indian mother and daughter showing their mehndi hands together, matching happiness, traditional outfits, warm interior lighting, emotional family celebration.',
          },
          {
            'title': 'Mehndi Sangeet Vibes',
            'platform': 'Leonardo AI',
            'description': 'Dancing with mehndi',
            'text': 'Indian girl dancing at a mehndi function, mehndi hands visible in motion, blurred lights, colorful dress, energetic and festive Bollywood vibes.',
          },
          {
            'title': 'Drying the Henna',
            'platform': 'Midjourney',
            'description': 'Waiting for mehndi to dry',
            'text': 'Bride sitting patiently with her mehndi hands spread out, lemon and sugar water spray, friends around her, evening fairy lights, cozy and festive atmosphere.',
          },
          {
            'title': 'Groom’s Name Hunt',
            'platform': 'Stable Diffusion XL',
            'description': 'Close up of palm',
            'text': 'Bride showing her palm where the groom’s initials are hidden in the mehndi design, playful expression, artistic bokeh, romantic wedding tradition.',
          },
          {
            'title': 'Vibrant Mehndi Decor',
            'platform': 'Midjourney',
            'description': 'Event interior design',
            'text': 'Bohemian style Indian mehndi function decor, colorful drapes, dreamcatchers, marigolds, low seating with bolsters, outdoor evening setup, aesthetic event design.',
          },
        ];

      case 'Wedding Ceremony':
        return [
          {
            'title': 'The Varmala Moment',
            'platform': 'Midjourney',
            'description': 'Exchanging flower garlands',
            'text': 'Cinematic shot of Indian bride and groom exchanging flower garlands (Varmala), friends lifting them up, rose petals flying in the air, joyful expressions, 8k professional wedding photography.',
          },
          {
            'title': 'Sacred Pheras',
            'platform': 'DALL-E 3',
            'description': 'Walking around the fire',
            'text': 'Indian couple performing the sacred pheras around the holy fire, smoke rising, priest chanting in background, focused on their feet and the fire, spiritual and divine atmosphere.',
          },
          {
            'title': 'Applying the Sindoor',
            'platform': 'Leonardo AI',
            'description': 'Traditional marriage ritual',
            'text': 'Extreme close up of a groom applying red sindoor to the bride’s forehead, emotional eye contact, traditional mandap background, sacred and intimate wedding moment.',
          },
          {
            'title': 'Mangalsutra Ceremony',
            'platform': 'Stable Diffusion XL',
            'description': 'Groom tying the necklace',
            'text': 'Groom tying the sacred black bead mangalsutra around the bride’s neck, close-up of the jewelry, bride’s shy smile, soft lighting, cultural wedding ritual.',
          },
          {
            'title': 'Mandap Under the Stars',
            'platform': 'Midjourney',
            'description': 'Night wedding setup',
            'text': 'Open-air Indian wedding mandap at night, decorated with thousands of white tuberoses and crystal chandeliers, stars in the sky, luxurious and grand atmosphere.',
          },
          {
            'title': 'The Kanyadaan',
            'platform': 'DALL-E 3',
            'description': 'Emotional ritual of hands',
            'text': 'Close up of the father’s hands placing the bride’s hand into the groom’s hand, traditional brass vessel, water pouring ritual, emotional and symbolic, documentary style.',
          },
          {
            'title': 'Bride Entering Mandap',
            'platform': 'Midjourney',
            'description': 'Bridal entry with veil',
            'text': 'Indian bride walking towards the mandap under a floral canopy (Phoolon ki Chaadar) held by brothers, slow walk, glowing eyes, emotional and grand entry shot.',
          },
          {
            'title': 'Priest and Rituals',
            'platform': 'Leonardo AI',
            'description': 'Focus on Vedic rituals',
            'text': 'Hindu priest performing Vedic rituals, hands offering grains to fire, ancient scriptures, copper vessels, authentic Indian wedding atmosphere, focused lighting.',
          },
          {
            'title': 'Wedding Vows Glance',
            'platform': 'Stable Diffusion XL',
            'description': 'Candid look between couple',
            'text': 'Bride and groom looking at each other through the sacred fire, intense connection, orange glow on faces, emotional and romantic candid shot.',
          },
          {
            'title': 'Petals and Blessings',
            'platform': 'Midjourney',
            'description': 'Final ceremony exit',
            'text': 'Indian newlyweds walking out after the ceremony, family throwing flower petals, bright smiles, "Just Married" feeling, festive and colorful celebration photography.',
          },
        ];

      case 'Reception Party':
        return [
          {
            'title': 'Grand Sparkler Entry',
            'platform': 'Midjourney',
            'description': 'Couple entrance with cold fire',
            'text': 'Indian couple entering their wedding reception, cold fire sparklers on both sides, grand white stage, modern designer outfits, guests cheering, epic celebration shot.',
          },
          {
            'title': 'The First Dance',
            'platform': 'DALL-E 3',
            'description': 'Romantic ballroom dance',
            'text': 'Indian couple performing their first dance at reception, smoke machine effect on floor, blue and purple spotlights, romantic pose, luxury ballroom setting, cinematic.',
          },
          {
            'title': 'Cake Cutting Celebration',
            'platform': 'Leonardo AI',
            'description': 'Multi-tier wedding cake',
            'text': 'Couple cutting a 5-tier white floral wedding cake, champagne glasses nearby, laughing, elegant evening wear, luxury reception party, candid celebration.',
          },
          {
            'title': 'Reception Stage Decor',
            'platform': 'Stable Diffusion XL',
            'description': 'Luxury floral stage',
            'text': 'Grand Indian reception stage design, wall of white orchids and roses, gold velvet sofa, chandeliers, soft warm ambient lighting, high-end event design.',
          },
          {
            'title': 'Champagne Toast',
            'platform': 'Midjourney',
            'description': 'Groom’s speech moment',
            'text': 'Indian groom giving a speech at the reception, holding a champagne glass, bride laughing beside him, guests blurred in background, warm emotional atmosphere.',
          },
          {
            'title': 'Designer Couple Portrait',
            'platform': 'DALL-E 3',
            'description': 'Formal fashion pose',
            'text': 'Full length portrait of an Indian couple in high-fashion reception wear, man in tuxedo, woman in a heavy silver gown, luxury hotel lobby, Vogue style photography.',
          },
          {
            'title': 'Dance Floor Madness',
            'platform': 'Leonardo AI',
            'description': 'Candid party energy',
            'text': 'Group of guests and the couple dancing energetically on the reception floor, colorful disco lights, hands in the air, party energy, motion blur, fun celebration.',
          },
          {
            'title': 'The Rings Glance',
            'platform': 'Stable Diffusion XL',
            'description': 'Detail of wedding rings',
            'text': 'Close up of the couple’s hands intertwined on a table, wedding rings sparkling, blurred background of the party lights, romantic detail shot.',
          },
          {
            'title': 'Reception Bokeh Portrait',
            'platform': 'Midjourney',
            'description': 'Close-up with party lights',
            'text': 'Romantic close-up of Indian newlyweds, foreheads touching, thousands of fairy lights in the background creating beautiful bokeh, soft and warm, high resolution.',
          },
          {
            'title': 'Grand Family Photo',
            'platform': 'DALL-E 3',
            'description': 'Group portrait on stage',
            'text': 'Large Indian family group photo on the wedding reception stage, three generations, everyone dressed in formal wear, bright professional lighting, joyful legacy portrait.',
          },
        ];

      default:
        return [];
    }
  }
}
