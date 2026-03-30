// lib/services/seed/prompts/ai_tools_platforms_prompts.dart

class AIToolsPlatformsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Midjourney':
        return [
          {
            'title': 'V6 Photographic Realism',
            'platform': 'Midjourney',
            'description': 'The ultimate skin and light master',
            'text': 'Transform this reference into a hyper-realistic close-up. Use: [Subject description], shot on 85mm lens, f/1.8, natural highlights, high-resolution skin textures, photorealistic --v 6.0 --ar 4:5 --stylize 250 --v 6.0',

          },
          {
            'title': 'Cinematic Lighting Code',
            'platform': 'Midjourney',
            'description': 'Mastering atmosphere and mood',
            'text': 'Recreate this scene with cinematic lighting. Use: blue hour mood, volumetric fog, rim lighting, dramatic shadows, 8k resolution, cinematic color grading --v 6.0 --ar 16:9 --shanon 80',

          },
          {
            'title': 'Minimalist Architect',
            'platform': 'Midjourney',
            'description': 'Clean luxury design lines',
            'text': 'Convert this concept into a minimalist architectural render. Use: Brutalist style, concrete and glass textures, desert landscape, soft shadows, sharp focus --v 6.0 --ar 3:2 --no clutter',

          },
          {
            'title': 'Ethereal Glow Style',
            'platform': 'Midjourney',
            'description': 'Magical bioluminescent world',
            'text': 'Apply an ethereal glow effect. Use: bioluminescent flora, deep violet and teal tones, floating particles, dreamy bokeh, soft mist --v 6.0 --chaos 15 --stylize 400',

          },
          {
            'title': 'Vintage Film Stock',
            'platform': 'Midjourney',
            'description': 'Authentic 70s analog look',
            'text': 'Transform this into a 1970s film still. Use: shot on 35mm Kodachrome, heavy grain, light leaks, warm muted colors, nostalgic vibe --v 6.0 --ar 4:3 --stylize 150',

          },
          {
            'title': 'Double Exposure Pro',
            'platform': 'Midjourney',
            'description': 'Artistic overlapping images',
            'text': 'Generate a double exposure portrait. Use: [Subject A] merged with [Nature Element B], white background, sharp clean edges, surreal fine art style --v 6.0 --ar 2:3',
          },
          {
            'title': 'Product Hero Shot',
            'platform': 'Midjourney',
            'description': 'Clean e-commerce gadget style',
            'text': 'Convert this product into a luxury ad. Use: top-down flat lay, carbon fiber surface, electric blue accent lighting, ultra-clean, commercial photography --v 6.0 --q 2',

          },
          {
            'title': 'Macro Texture Focus',
            'platform': 'Midjourney',
            'description': 'Microscopic detail level',
            'text': 'Apply extreme macro focus. Use: 100mm macro lens, visible water droplets, refraction, incredible detail, shallow depth of field --v 6.0 --stop 90',
            'isFeatured': 'false',
          },
          {
            'title': 'Symmetric Vector Art',
            'platform': 'Midjourney',
            'description': 'Perfect logo-style geometry',
            'text': 'Transform this into a symmetric vector logo. Use: flat design, geometric precision, bold lines, solid background, minimalist aesthetic --v 6.0 --no shading',
            'isFeatured': 'false',
          },
          {
            'title': 'Editorial Fashion High',
            'platform': 'Midjourney',
            'description': 'Vogue magazine style',
            'text': 'Recreate as a Vogue editorial. Use: avant-garde pose, high-contrast flash, designer textures, sharp bone structure, high-end fashion photography --v 6.0 --ar 4:5',
            'isFeatured': 'false',
          },
        ];

      case 'DALL-E 3':
        return [
          {
            'title': 'Storytelling precision',
            'platform': 'DALL-E 3',
            'description': 'Exact descriptive scene building',
            'text': 'Take this basic idea and turn it into a detailed story: [Description]. Ensure every specific object mentioned is placed exactly, using a digital painting style with warm, vibrant lighting.',
            'isFeatured': 'true',
          },
          {
            'title': 'Exact Text Poster',
            'platform': 'DALL-E 3',
            'description': 'Rendering specific words in art',
            'text': 'Design a travel poster for [City Name]. The image should show [Landmark] at sunset. At the very top, include the text "[WORD]" in bold, elegant gold Art Deco lettering.',
            'isFeatured': 'true',
          },
          {
            'title': 'Anatomical Correctness',
            'platform': 'DALL-E 3',
            'description': 'Fixing hands and poses',
            'text': 'A realistic photo of [Person] performing [Complex Action]. Focus on correct hand finger placement and muscle tension. The lighting should be sharp to highlight anatomical detail.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mythical Creature Mix',
            'platform': 'DALL-E 3',
            'description': 'Merging two animals perfectly',
            'text': 'Create a high-quality creature design that is a hybrid of a [Animal 1] and a [Animal 2]. Combine their features logically (e.g., fur patterns of 1, wings of 2). Realistic textures.',
            'isFeatured': 'false',
          },
          {
            'title': 'Infographic Creator',
            'platform': 'DALL-E 3',
            'description': 'Scientific and clean layouts',
            'text': 'A professional infographic style illustration of [Topic]. Use a cross-section view with clear labels for each part. Keep the colors educational and the layout organized.',
            'isFeatured': 'false',
          },
          {
            'title': 'Claymation 3D Style',
            'platform': 'DALL-E 3',
            'description': 'Plasticine character look',
            'text': 'Recreate this character in a claymation style. Add visible thumbprint textures on the surface to make it look like real hand-molded clay. Use soft studio lighting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Historical Period Accuracy',
            'platform': 'DALL-E 3',
            'description': 'Authentic time-travel photos',
            'text': 'A realistic photograph from the year [Year] in [Location]. Ensure the clothing, architecture, and technology shown are 100% historically accurate for that specific decade.',
            'isFeatured': 'false',
          },
          {
            'title': 'Blueprint to Reality',
            'platform': 'DALL-E 3',
            'description': '3D Cutaway architecture',
            'text': 'A creative 3D cutaway of a [Building Type]. Show the internal rooms and external structure simultaneously. Part-blueprint, part-realistic render. High technical detail.',
            'isFeatured': 'false',
          },
          {
            'title': 'Whimsical Storybook',
            'platform': 'DALL-E 3',
            'description': 'Classic children illustration',
            'text': 'Transform this scene into a whimsical children’s storybook illustration. Use soft watercolor textures, gentle pencil outlines, and a cozy, magical atmosphere.',
            'isFeatured': 'false',
          },
          {
            'title': 'Multi-View Character',
            'platform': 'DALL-E 3',
            'description': 'Front, side, and back views',
            'text': 'A professional character reference sheet for [Character Name]. Show the character in a T-pose from three angles: front, side, and back. Clean white background.',
            'isFeatured': 'false',
          },
        ];

      case 'Stable Diffusion':
        return [
          {
            'title': 'Hyper-Real 8K Textures',
            'platform': 'Stable Diffusion',
            'description': 'The master of photographic detail',
            'text': 'Convert this photo into a masterpiece of detail. Use: [Subject], extremely detailed skin pores, 8k UHD, cinematic lighting, sharp focus, masterpiece, realistic eyes, high quality.',
            'isFeatured': 'true',
          },
          {
            'title': 'Cybernetic Fusion',
            'platform': 'Stable Diffusion',
            'description': 'Merging biology and machine',
            'text': 'Apply a cybernetic transformation. Use: half-human half-robot, internal golden gears visible through glass skin, glowing blue circuits, dark industrial background, intricate mechanical design.',
            'isFeatured': 'false',
          },
          {
            'title': 'Concept Art Matte',
            'platform': 'Stable Diffusion',
            'description': 'Large scale movie environments',
            'text': 'Create an epic scale matte painting. Use: [Location], atmospheric haze, cinematic scale, high-end movie concept art, detailed world-building, grand perspective.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fluid Liquid Motion',
            'platform': 'Stable Diffusion',
            'description': 'Splash and flow dynamics',
            'text': 'Generate a high-speed splash effect. Use: [Liquid type] forming the shape of [Object], droplets frozen in mid-air, dark reflective background, dramatic lighting, luxury aesthetic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Gothic Dark Mood',
            'platform': 'Stable Diffusion',
            'description': 'Moody architectural horror',
            'text': 'Apply a dark gothic atmosphere. Use: [Scene], moonlight shadows, stained glass patterns, misty air, hyper-detailed stone carvings, grand and spooky aesthetic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mechanical Clockwork',
            'platform': 'Stable Diffusion',
            'description': 'Intricate steampunk detailing',
            'text': 'Convert to steampunk style. Use: [Object], brass and copper machinery, steam exhaust, glowing lanterns, sunset sky, intricate clockwork details, high resolution.',
            'isFeatured': 'false',
          },
          {
            'title': 'Silk & Textile Flow',
            'platform': 'Stable Diffusion',
            'description': 'Mastering fabric physics',
            'text': 'Focus on textile realism. Use: [Color] silk fabric flowing, realistic satin sheen, micro-fiber details, soft ripples, high-fashion background, abstract textile photography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Elemental Power Art',
            'platform': 'Stable Diffusion',
            'description': 'Fire, lava, and lightning',
            'text': 'Apply elemental effects. Use: [Object] surrounded by [Element], embers flying, intense glow, dark stormy sky, powerful nature, cinematic lighting, ultra-realistic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Ancient Parchment',
            'platform': 'Stable Diffusion',
            'description': 'Tattered vintage paper look',
            'text': 'Transform into an ancient manuscript. Use: tattered parchment, burnt edges, handwritten calligraphy, mystical symbols, ink stains, realistic texture, top-down view.',
            'isFeatured': 'false',
          },
          {
            'title': 'Glass Scuplture Logic',
            'platform': 'Stable Diffusion',
            'description': 'Mastering light refraction',
            'text': 'Recreate as a glass sculpture. Use: made entirely of cracked glass, light refracting rainbow colors, dark studio background, sharp focus, artistic glasswork photography.',
            'isFeatured': 'false',
          },
        ];

      case 'Leonardo AI':
        return [
          {
            'title': 'RPG Hero Alchemy',
            'platform': 'Leonardo AI',
            'description': 'Pro-level game character art',
            'text': 'Transform this person into a fantasy RPG warrior. Use: heavy plate armor, dragon motifs, snowy mountain background, Leonardo Alchemy style, cinematic lighting, masterpiece.',
            'isFeatured': 'true',
          },
          {
            'title': 'Makoto Shinkai Anime',
            'platform': 'Leonardo AI',
            'description': 'Vibrant artistic scenery',
            'text': 'Recreate this landscape in Shinkai style. Use: serene garden, cherry blossoms, sunset sky, soft pastel colors, aesthetic anime background, 4k high resolution.',
            'isFeatured': 'false',
          },
          {
            'title': '3D Avatar Headshot',
            'platform': 'Leonardo AI',
            'description': 'Cute Pixar-style characters',
            'text': 'Convert this face into a 3D avatar. Use: big eyes, stylized hair, futuristic headphones, Pixar style, clean studio background, soft shadows, adorable 3D art.',
            'isFeatured': 'true',
          },
          {
            'title': 'Dark Magic Portrait',
            'platform': 'Leonardo AI',
            'description': 'Moody mystical energy',
            'text': 'Apply dark sorcery effects. Use: glowing shadow energy orb, hooded cloak, ancient ruins, dramatic low-key lighting, sinister atmosphere, fantasy illustration.',
            'isFeatured': 'false',
          },
          {
            'title': 'Concept Superbike',
            'platform': 'Leonardo AI',
            'description': 'High-end vehicle concepts',
            'text': 'Transform this bike into a futuristic concept. Use: glowing wheel rims, carbon fiber body, neon city night, motion blur, tech-noir aesthetic, high-end concept art.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mythical Phoenix Rise',
            'platform': 'Leonardo AI',
            'description': 'Elemental creature fire',
            'text': 'Recreate as a phoenix rising. Use: wings of golden and red fire, embers flying, vibrant colors, Leonardo Vision XL style, epic fantasy art.',
            'isFeatured': 'false',
          },
          {
            'title': 'Luxury Skeleton Watch',
            'platform': 'Leonardo AI',
            'description': '3D product visualization',
            'text': 'Render this product as a luxury watch. Use: internal mechanical movement visible, rose gold and black leather, dramatic rim lighting, professional 3D visualization.',
            'isFeatured': 'false',
          },
          {
            'title': 'Sunken Sea Mystery',
            'platform': 'Leonardo AI',
            'description': 'Underwater environmental art',
            'text': 'Transform into an underwater ruins scene. Use: coral growth, schools of fish, sunlight rays through deep blue water, mysterious and detailed environment.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fairy Tale Architecture',
            'platform': 'Leonardo AI',
            'description': 'Magical glowing houses',
            'text': 'Convert this house into an enchanted treehouse. Use: built on a giant oak, circular windows, hanging lanterns, magical forest, detailed digital painting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Cyberpunk Samurai',
            'platform': 'Leonardo AI',
            'description': 'Futuristic traditional mix',
            'text': 'Apply a futuristic samurai look. Use: cybernetic armor, katana made of light, rainy neon city, Leonardo Signature style, cinematic masterpiece.',
            'isFeatured': 'false',
          },
        ];

      case 'Kling & Runway':
        return [
          {
            'title': 'Drone Coastal Flight',
            'platform': 'Kling AI',
            'description': 'Smooth landscape motion commands',
            'text': 'Video motion command: Generate a cinematic drone flight over [Location]. Include smooth camera movement, realistic water physics, and sunset lighting. 4k resolution.',
            'isFeatured': 'true',
          },
          {
            'title': 'Talking Human Portrait',
            'platform': 'Runway ML',
            'description': 'Animate a face with speech',
            'text': 'Video animation: Make this person speak the following script. Ensure natural eye blinking, subtle head tilts, and realistic mouth synchronization. Professional background.',
            'isFeatured': 'true',
          },
          {
            'title': '200MPH Speed Action',
            'platform': 'Kling AI',
            'description': 'High-velocity motion blur',
            'text': 'Video motion command: [Object] racing through [Setting] at high speed. Add intense motion blur, dust clouds kicking up, and a low-angle tracking camera shot.',
            'isFeatured': 'false',
          },
          {
            'title': 'Object Morphing',
            'platform': 'Runway ML',
            'description': 'Seamless transformation video',
            'text': 'Creative transition: Animate [Object A] slowly morphing and transforming into [Object B]. Ensure the transition is liquid-smooth and visually artistic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Slow Motion Culinary',
            'platform': 'Kling AI',
            'description': 'Professional food ad motion',
            'text': 'Video motion command: A close-up slow-motion shot of [Food item] being prepared. Include steam rising, sauces splashing, and vibrant high-quality food commercial lighting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Time-Lapse Blooming',
            'platform': 'Runway ML',
            'description': 'Growth and change animation',
            'text': 'Video animation: Create a time-lapse of [Subject] growing or changing from [State A] to [State B]. Smooth frames, beautiful nature cinematography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fashion Runway Walk',
            'platform': 'Kling AI',
            'description': 'Human walking and fabric physics',
            'text': 'Video motion command: A fashion model walking towards the camera. Focus on the realistic movement of the [Fabric type] dress and the rhythmic walking pace.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fluid Aquatic Motion',
            'platform': 'Runway ML',
            'description': 'Underwater movement physics',
            'text': 'Video animation: [Subject] swimming underwater. Focus on fluid movement, rising bubbles, and sunlight refracting through the water surface. Slow and peaceful.',
            'isFeatured': 'false',
          },
          {
            'title': 'Vibrant Particle Burst',
            'platform': 'Kling AI',
            'description': 'Exploding color effects',
            'text': 'Video motion command: [Action] causes a massive burst of [Color/Particles]. Slow motion, extreme detail of every individual particle flying through the air.',
            'isFeatured': 'false',
          },
          {
            'title': 'Sci-Fi Portal Entry',
            'platform': 'Runway ML',
            'description': 'VFX gateway animation',
            'text': 'Creative VFX: A futuristic portal opening in [Setting]. Show swirling energy and a glimpse of another dimension through the portal. High-quality visual effects.',
            'isFeatured': 'false',
          },
        ];

      case 'Flux & Ideogram':
        return [
          {
            'title': 'Minimalist Brand Typography',
            'platform': 'Ideogram',
            'description': 'Rendering clear text in logos',
            'text': 'Design a minimalist logo for "[NAME]". Include a [Icon] symbol. The text must be in a clean modern sans-serif font. White background, [Color] scheme.',
            'isFeatured': 'true',
          },
          {
            'title': 'Movie Poster Title',
            'platform': 'Flux AI',
            'description': 'Cinematic text integration',
            'text': 'A movie poster titled "[TITLE]". The background shows [Scene]. The title text should be in bold, glowing [Color] neon with a slight glitch effect. High contrast.',
            'isFeatured': 'true',
          },
          {
            'title': 'Editorial Magazine Layout',
            'platform': 'Ideogram',
            'description': 'Complex multi-font covers',
            'text': 'A fashion magazine cover titled "[NAME]". Include headlines like "[Heading 1]" and "[Heading 2]" in varied stylish fonts. Professional layout and high-fashion photo.',
            'isFeatured': 'false',
          },
          {
            'title': 'Neon Handwriting Wall',
            'platform': 'Flux AI',
            'description': 'Realistic neon sign text',
            'text': 'A realistic photo of a brick wall at night with a bright [Color] neon sign that says "[TEXT]" in cursive handwriting style. Realistic reflections on the bricks.',
            'isFeatured': 'false',
          },
          {
            'title': 'Luxury Business Card',
            'platform': 'Ideogram',
            'description': 'Professional name card design',
            'text': 'A luxury business card design for "[NAME], [Title]". Use an elegant serif font on a deep [Color] background with gold foil text. Minimalist and premium.',
            'isFeatured': 'false',
          },
          {
            'title': 'Distressed Vintage Apparel',
            'platform': 'Flux AI',
            'description': 'Retro t-shirt graphic text',
            'text': 'A vintage 90s style t-shirt graphic. Illustration of [Subject] with the text "[TEXT]" in distressed, faded retro typography. Aesthetic and trendy.',
            'isFeatured': 'false',
          },
          {
            'title': 'App UI Landing Page',
            'platform': 'Ideogram',
            'description': 'User interface text and icons',
            'text': 'A sleek mobile app landing page for "[App Name]". Include clear text for buttons and headers. Modern UI, clean white and [Color] palette.',
            'isFeatured': 'false',
          },
          {
            'title': 'Gourmet Packaging Label',
            'platform': 'Flux AI',
            'description': 'Artisan product typography',
            'text': 'A label design for a [Product]. Text "[NAME]" in elegant script. Illustrations of [Ingredient]. Earthy tones, professional packaging typography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Street Billboard Ad',
            'platform': 'Ideogram',
            'description': 'Large scale advertising text',
            'text': 'A city billboard showing an ad for [Product]. Text "[SLOGAN]" in massive bold letters. Dynamic photography and attention-grabbing layout.',
            'isFeatured': 'false',
          },
          {
            'title': 'Aesthetic Quote Post',
            'platform': 'Flux AI',
            'description': 'Social media typography art',
            'text': 'A beautiful aesthetic background of [Scene]. Overlaid text says "[QUOTE]" in very clean, readable, elegant typography. Perfect for Instagram.',
            'isFeatured': 'false',
          },
        ];

      default:
        return [];
    }
  }
}