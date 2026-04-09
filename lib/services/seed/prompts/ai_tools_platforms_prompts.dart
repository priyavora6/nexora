
// lib/services/seed/prompts/ai_tools_platforms_prompts.dart

class AIToolsPlatformsPrompts {
  static List<Map<String, dynamic>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Midjourney':
        return [
          {
            'title': 'V6 Photographic Realism',
            'platform': 'Midjourney',
            'description': 'The ultimate skin and light master',
            'text': 'Hyper-realistic close-up portrait of an elderly man, shot on 85mm lens, f/1.8, natural sunlight highlights, ultra-high-resolution skin textures, pores and wrinkles visible --v 6.0 --ar 4:5 --stylize 250',
            'isFeatured': 'true',
          },
          {
            'title': 'Cinematic Lighting Code',
            'platform': 'Midjourney',
            'description': 'Mastering atmosphere and mood',
            'text': 'A lonely cyberpunk street in the rain, blue hour mood, volumetric fog, orange rim lighting, dramatic shadows, 8k resolution, cinematic color grading --v 6.0 --ar 16:9 --style raw',
            'isFeatured': 'true',
          },
          {
            'title': 'Minimalist Architect',
            'platform': 'Midjourney',
            'description': 'Clean luxury design lines',
            'text': 'Minimalist architectural render of a glass villa in a desert landscape, concrete and glass textures, soft evening shadows, sharp focus, high-end interior design --v 6.0 --ar 3:2',
            'isFeatured': 'false',
          },
          {
            'title': 'Ethereal Glow Style',
            'platform': 'Midjourney',
            'description': 'Magical bioluminescent world',
            'text': 'Ethereal bioluminescent forest, deep violet and teal tones, floating light particles, dreamy bokeh, soft mist, magical atmosphere --v 6.0 --chaos 15 --stylize 400',
            'isFeatured': 'false',
          },
          {
            'title': 'Vintage Film Stock',
            'platform': 'Midjourney',
            'description': 'Authentic 70s analog look',
            'text': 'A 1970s street fashion still, shot on 35mm Kodachrome, heavy grain, light leaks, warm muted colors, nostalgic vibe, authentic film aesthetic --v 6.0 --ar 4:3',
            'isFeatured': 'false',
          },
          {
            'title': 'Double Exposure Pro',
            'platform': 'Midjourney',
            'description': 'Artistic overlapping images',
            'text': 'Double exposure portrait of a woman merged with a dense pine forest, white background, sharp clean edges, surreal fine art style, minimalist --v 6.0 --ar 2:3',
            'isFeatured': 'false',
          },
          {
            'title': 'Product Hero Shot',
            'platform': 'Midjourney',
            'description': 'Clean e-commerce gadget style',
            'text': 'Luxury wireless headphones, top-down flat lay on a carbon fiber surface, electric blue accent lighting, ultra-clean, commercial photography --v 6.0 --q 2',
            'isFeatured': 'false',
          },
          {
            'title': 'Macro Texture Focus',
            'platform': 'Midjourney',
            'description': 'Microscopic detail level',
            'text': 'Extreme macro focus on a dragonfly wing, visible water droplets with refraction, incredible iridescent detail, shallow depth of field --v 6.0 --stop 90',
            'isFeatured': 'false',
          },
          {
            'title': 'Symmetric Vector Art',
            'platform': 'Midjourney',
            'description': 'Perfect logo-style geometry',
            'text': 'Symmetric vector logo of a wolf, flat design, geometric precision, bold lines, solid white background, minimalist aesthetic --v 6.0 --no shading',
            'isFeatured': 'false',
          },
          {
            'title': 'Editorial Fashion High',
            'platform': 'Midjourney',
            'description': 'Vogue magazine style',
            'text': 'Avant-garde fashion editorial, model in a sculptural metal dress, high-contrast flash, sharp bone structure, high-end fashion photography --v 6.0 --ar 4:5',
            'isFeatured': 'false',
          },
        ];

      case 'DALL-E 3':
        return [
          {
            'title': 'Storytelling Precision',
            'platform': 'DALL-E 3',
            'description': 'Exact descriptive scene building',
            'text': 'A detailed digital painting of a tiny mouse wearing a knight\'s armor, standing guard over a single glowing strawberry in a dark attic, warm candle lighting.',
            'isFeatured': 'true',
          },
          {
            'title': 'Exact Text Poster',
            'platform': 'DALL-E 3',
            'description': 'Rendering specific words in art',
            'text': 'A retro travel poster for "MARS". The image shows a futuristic red city under a glass dome. The word "MARS" is written in massive, bold, gold 3D lettering at the top.',
            'isFeatured': 'true',
          },
          {
            'title': 'Anatomical Correctness',
            'platform': 'DALL-E 3',
            'description': 'Fixing hands and poses',
            'text': 'A realistic photo of a professional pianist\'s hands playing a grand piano. Focus on the correct placement of all ten fingers on the keys and realistic muscle tension.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mythical Creature Mix',
            'platform': 'DALL-E 3',
            'description': 'Merging two animals perfectly',
            'text': 'A high-quality creature design of a hybrid between a tiger and a peacock. The creature has tiger fur with iridescent peacock eye patterns, and massive colorful wings.',
            'isFeatured': 'false',
          },
          {
            'title': 'Infographic Creator',
            'platform': 'DALL-E 3',
            'description': 'Scientific and clean layouts',
            'text': 'A professional infographic illustration showing the internal layers of the Earth. Use a cross-section view with clear, readable labels for the Core, Mantle, and Crust.',
            'isFeatured': 'false',
          },
          {
            'title': 'Claymation 3D Style',
            'platform': 'DALL-E 3',
            'description': 'Plasticine character look',
            'text': 'A character made in a claymation style. Include visible thumbprint textures on the surface to make it look like real hand-molded clay. Soft studio lighting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Historical Period Accuracy',
            'platform': 'DALL-E 3',
            'description': 'Authentic time-travel photos',
            'text': 'A realistic photograph of a bustling New York street in 1924. Ensure the clothing, Ford Model T cars, and architecture are 100% historically accurate.',
            'isFeatured': 'false',
          },
          {
            'title': 'Blueprint to Reality',
            'platform': 'DALL-E 3',
            'description': '3D Cutaway architecture',
            'text': 'A 3D cutaway of a modern smart home. Show the internal rooms, furniture, and wiring simultaneously. Part-blueprint, part-realistic render. High technical detail.',
            'isFeatured': 'false',
          },
          {
            'title': 'Whimsical Storybook',
            'platform': 'DALL-E 3',
            'description': 'Classic children illustration',
            'text': 'A whimsical children’s storybook illustration of a cat drinking tea with a dragon. Use soft watercolor textures and gentle pencil outlines.',
            'isFeatured': 'false',
          },
          {
            'title': 'Multi-View Character',
            'platform': 'DALL-E 3',
            'description': 'Front, side, and back views',
            'text': 'A professional character reference sheet for a space explorer. Show the character in a T-pose from three angles: front, side, and back. Clean white background.',
            'isFeatured': 'false',
          },
        ];

      case 'Stable Diffusion':
        return [
          {
            'title': 'Hyper-Real 8K Textures',
            'platform': 'Stable Diffusion',
            'description': 'The master of photographic detail',
            'text': 'Portrait of a warrior, extremely detailed skin pores, 8k UHD, cinematic lighting, sharp focus, masterpiece, realistic eyes, high quality, highly detailed surface.',
            'isFeatured': 'true',
          },
          {
            'title': 'Cybernetic Fusion',
            'platform': 'Stable Diffusion',
            'description': 'Merging biology and machine',
            'text': 'Half-human half-robot, internal golden gears visible through glass skin, glowing blue circuits, dark industrial background, intricate mechanical design, 8k.',
            'isFeatured': 'false',
          },
          {
            'title': 'Concept Art Matte',
            'platform': 'Stable Diffusion',
            'description': 'Large scale movie environments',
            'text': 'Epic scale matte painting of a floating city, atmospheric haze, cinematic scale, high-end movie concept art, detailed world-building, grand perspective.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fluid Liquid Motion',
            'platform': 'Stable Diffusion',
            'description': 'Splash and flow dynamics',
            'text': 'A high-speed splash of liquid gold forming the shape of a rose, droplets frozen in mid-air, dark reflective background, dramatic lighting, luxury aesthetic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Gothic Dark Mood',
            'platform': 'Stable Diffusion',
            'description': 'Moody architectural horror',
            'text': 'A dark gothic cathedral interior, moonlight shadows, stained glass patterns, misty air, hyper-detailed stone carvings, grand and spooky aesthetic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mechanical Clockwork',
            'platform': 'Stable Diffusion',
            'description': 'Intricate steampunk detailing',
            'text': 'A steampunk owl made of brass and copper machinery, steam exhaust, glowing amber eyes, intricate clockwork details, high resolution, sharp focus.',
            'isFeatured': 'false',
          },
          {
            'title': 'Silk & Textile Flow',
            'platform': 'Stable Diffusion',
            'description': 'Mastering fabric physics',
            'text': 'Crimson silk fabric flowing in the wind, realistic satin sheen, micro-fiber details, soft ripples, high-fashion background, abstract textile photography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Elemental Power Art',
            'platform': 'Stable Diffusion',
            'description': 'Fire, lava, and lightning',
            'text': 'A sword stuck in a rock surrounded by flowing lava and lightning strikes, embers flying, intense glow, dark stormy sky, cinematic lighting, ultra-realistic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Ancient Parchment',
            'platform': 'Stable Diffusion',
            'description': 'Tattered vintage paper look',
            'text': 'An ancient manuscript on tattered parchment, burnt edges, handwritten calligraphy, mystical symbols, ink stains, realistic paper texture, top-down view.',
            'isFeatured': 'false',
          },
          {
            'title': 'Glass Sculpture Logic',
            'platform': 'Stable Diffusion',
            'description': 'Mastering light refraction',
            'text': 'A horse sculpture made entirely of cracked glass, light refracting rainbow colors, dark studio background, sharp focus, artistic glasswork photography.',
            'isFeatured': 'false',
          },
        ];

      case 'Leonardo AI':
        return [
          {
            'title': 'RPG Hero Alchemy',
            'platform': 'Leonardo AI',
            'description': 'Pro-level game character art',
            'text': 'A fantasy RPG warrior in heavy plate armor, dragon motifs, snowy mountain background, Leonardo Alchemy style, cinematic lighting, masterpiece, 8k.',
            'isFeatured': 'true',
          },
          {
            'title': 'Makoto Shinkai Anime',
            'platform': 'Leonardo AI',
            'description': 'Vibrant artistic scenery',
            'text': 'A serene Japanese garden, cherry blossoms, sunset sky, soft pastel colors, aesthetic anime style, 4k high resolution, vibrant atmosphere.',
            'isFeatured': 'false',
          },
          {
            'title': '3D Avatar Headshot',
            'platform': 'Leonardo AI',
            'description': 'Cute Pixar-style characters',
            'text': 'A 3D character avatar with big expressive eyes, stylized hair, futuristic headphones, Pixar style, clean studio background, soft shadows, 3D art.',
            'isFeatured': 'true',
          },
          {
            'title': 'Dark Magic Portrait',
            'platform': 'Leonardo AI',
            'description': 'Moody mystical energy',
            'text': 'A sorcerer holding a glowing shadow energy orb, hooded cloak, ancient ruins background, dramatic low-key lighting, sinister atmosphere, fantasy illustration.',
            'isFeatured': 'false',
          },
          {
            'title': 'Concept Superbike',
            'platform': 'Leonardo AI',
            'description': 'High-end vehicle concepts',
            'text': 'A futuristic superbike with glowing wheel rims, carbon fiber body, neon city night background, motion blur, tech-noir aesthetic, high-end concept art.',
            'isFeatured': 'false',
          },
          {
            'title': 'Mythical Phoenix Rise',
            'platform': 'Leonardo AI',
            'description': 'Elemental creature fire',
            'text': 'A majestic phoenix rising from ashes, wings of golden and red fire, embers flying, vibrant colors, Leonardo Vision XL style, epic fantasy art.',
            'isFeatured': 'false',
          },
          {
            'title': 'Luxury Skeleton Watch',
            'platform': 'Leonardo AI',
            'description': '3D product visualization',
            'text': 'A luxury skeleton watch, internal mechanical movement visible, rose gold and black leather, dramatic rim lighting, professional 3D visualization.',
            'isFeatured': 'false',
          },
          {
            'title': 'Sunken Sea Mystery',
            'platform': 'Leonardo AI',
            'description': 'Underwater environmental art',
            'text': 'Underwater ancient ruins, coral growth, schools of exotic fish, sunlight rays through deep blue water, mysterious and detailed environment.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fairy Tale Architecture',
            'platform': 'Leonardo AI',
            'description': 'Magical glowing houses',
            'text': 'An enchanted treehouse built on a giant oak, circular windows, hanging lanterns, magical forest background, detailed digital painting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Cyberpunk Samurai',
            'platform': 'Leonardo AI',
            'description': 'Futuristic traditional mix',
            'text': 'A futuristic samurai with cybernetic armor, katana made of pure light, rainy neon city background, Leonardo Signature style, cinematic masterpiece.',
            'isFeatured': 'false',
          },
        ];

      case 'Kling Runway':
        return [
          {
            'title': 'Cinematic Drone Frame',
            'platform': 'Kling AI',
            'description': 'Wide landscape motion look',
            'text': 'Cinematic drone shot of a coastal road winding through green mountains, ocean waves crashing on rocks, golden hour sunset, 4k high-end cinematography.',
            'isFeatured': 'true',
          },
          {
            'title': 'Talking Human Portrait',
            'platform': 'Runway ML',
            'description': 'Realistic facial animation',
            'text': 'Close-up of a human face with natural eye blinking, subtle head tilts, and realistic expressions. Professional studio lighting, blurred office background.',
            'isFeatured': 'true',
          },
          {
            'title': 'High Velocity Motion',
            'platform': 'Kling AI',
            'description': 'Action blur cinematography',
            'text': 'A sports car racing through a tunnel at high speed, intense motion blur on the walls, glowing tail lights, low-angle tracking shot, cinematic action.',
            'isFeatured': 'false',
          },
          {
            'title': 'Object Morphing Frame',
            'platform': 'Runway ML',
            'description': 'Seamless transformation visual',
            'text': 'A visual of an apple slowly morphing into a lightbulb, liquid-smooth transition, white minimalist background, artistic creative concept.',
            'isFeatured': 'false',
          },
          {
            'title': 'Slow Motion Culinary',
            'platform': 'Kling AI',
            'description': 'Food commercial aesthetic',
            'text': 'Professional cinematic slow-motion shot of a dark chocolate bar being broken in half, fine cocoa powder particles in the air, warm studio lighting, macro detail, high-quality food commercial aesthetic.',
            'isFeatured': 'false',
          },
          {
            'title': 'Nature Time-Lapse',
            'platform': 'Runway ML',
            'description': 'Growth and change visual',
            'text': 'A time-lapse of a flower blooming in the forest, morning dew disappearing, soft sun rays filtering through trees, cinematic nature photography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fashion Runway Walk',
            'platform': 'Kling AI',
            'description': 'Fabric and movement physics',
            'text': 'A fashion model walking on a runway, focusing on the realistic movement of a silk dress, rhythmic walking pace, high-contrast fashion show lighting.',
            'isFeatured': 'false',
          },
          {
            'title': 'Fluid Aquatic Motion',
            'platform': 'Runway ML',
            'description': 'Underwater movement physics',
            'text': 'A person swimming in deep blue water, fluid motion, rising bubbles, sunlight refracting through the surface, peaceful aquatic atmosphere.',
            'isFeatured': 'false',
          },
          {
            'title': 'Particle Burst Frame',
            'platform': 'Kling AI',
            'description': 'Exploding color effects',
            'text': 'A massive burst of colorful powder particles in mid-air, frozen motion, extreme detail of every grain, dark background, vibrant artistic effect.',
            'isFeatured': 'false',
          },
          {
            'title': 'VFX Portal Environment',
            'platform': 'Runway ML',
            'description': 'Sci-fi gateway visual',
            'text': 'A futuristic energy portal opening in a desert, swirling purple light, sand blowing into the portal, high-quality visual effects, sci-fi concept.',
            'isFeatured': 'false',
          },
        ];

      case 'Flux Ideogram':
        return [
          {
            'title': 'Minimalist Typography',
            'platform': 'Ideogram',
            'description': 'Rendering clear text in logos',
            'text': 'A minimalist logo for a brand called "NEXORA". The word "NEXORA" is in a clean modern sans-serif font below a geometric star icon. White background.',
            'isFeatured': 'true',
          },
          {
            'title': 'Movie Poster Title',
            'platform': 'Flux AI',
            'description': 'Cinematic text integration',
            'text': 'A movie poster titled "THE LAST FRONTIER". Background shows a space station. The title is in bold, glowing blue neon with a slight glitch effect.',
            'isFeatured': 'true',
          },
          {
            'title': 'Magazine Layout Pro',
            'platform': 'Ideogram',
            'description': 'Complex multi-font covers',
            'text': 'A fashion magazine cover titled "STYLE". Headlines "Spring 2024" and "The New Minimal" in varied stylish fonts. Professional layout, model photo background.',
            'isFeatured': 'false',
          },
          {
            'title': 'Neon Handwriting Wall',
            'platform': 'Flux AI',
            'description': 'Realistic neon sign text',
            'text': 'A realistic photo of a brick wall at night with a bright pink neon sign that says "Love Yourself" in cursive handwriting style. Realistic reflections.',
            'isFeatured': 'false',
          },
          {
            'title': 'Luxury Business Card',
            'platform': 'Ideogram',
            'description': 'Professional name card design',
            'text': 'A luxury business card for "Jane Doe, CEO". Elegant serif font on a deep navy background with gold foil text. Minimalist and premium.',
            'isFeatured': 'false',
          },
          {
            'title': 'Vintage Apparel Graphic',
            'platform': 'Flux AI',
            'description': 'Retro t-shirt typography',
            'text': 'A vintage 90s style t-shirt graphic of a mountain. Text "ALASKA" in distressed, faded retro typography. Aesthetic and trendy streetwear look.',
            'isFeatured': 'false',
          },
          {
            'title': 'App UI Landing Page',
            'platform': 'Ideogram',
            'description': 'User interface text and icons',
            'text': 'A sleek mobile app landing page for "FINTECH". Include clear text for "Login" and "Get Started" buttons. Modern UI, clean white and blue palette.',
            'isFeatured': 'false',
          },
          {
            'title': 'Gourmet Packaging',
            'platform': 'Flux AI',
            'description': 'Artisan product typography',
            'text': 'A label design for "ORGANIC HONEY". Text in elegant script. Illustrations of bees and flowers. Earthy tones, professional packaging typography.',
            'isFeatured': 'false',
          },
          {
            'title': 'Street Billboard Ad',
            'platform': 'Ideogram',
            'description': 'Large scale advertising text',
            'text': 'A massive city billboard showing an ad for "NEXUS COFFEE". Text "AWAKEN YOUR SENSES" in bold letters. Dynamic photography, urban background.',
            'isFeatured': 'false',
          },
          {
            'title': 'Aesthetic Quote Post',
            'platform': 'Flux AI',
            'description': 'Social media typography art',
            'text': 'A beautiful aesthetic background of a sunset beach. Overlaid text says "Dream Big" in very clean, readable, elegant typography. Minimalist Instagram style.',
            'isFeatured': 'false',
          },
        ];

      default:
        return [];
    }
  }
}
