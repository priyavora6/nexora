class GamingEsportsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Cyberpunk Hero':
        return [
          {'title': 'Neon Night Stalker', 'platform': 'Midjourney', 'description': 'Neon-lit cyberpunk transformation', 'text': 'A person transformed into a Cyberpunk 2077 hero, wearing glowing LED techwear, cybernetic facial implants, rainy night city background, neon blue and pink lighting, hyper-realistic skin texture, 8k cinematic render'},
          {'title': 'Chrome Street Samurai', 'platform': 'DALL-E 3', 'description': 'Futuristic samurai style', 'text': 'A person as a futuristic street samurai, metallic chrome jacket, holding a glowing katana, dark urban background with holographic ads, sharp focus, digital art style'},
          {'title': 'Cyber Medic', 'platform': 'Leonardo AI', 'description': 'High-tech medical specialist', 'text': 'A person as a high-tech cyberpunk medic, wearing white and orange tactical gear, glowing HUD interface in front of eyes, futuristic hospital background, soft glowing light, intricate detail'},
          {'title': 'Netrunner Specialist', 'platform': 'Flux AI', 'description': 'Hacker style transition', 'text': 'A person as a netrunner hacker, cables connecting from head to a terminal, glowing green code reflecting on face, dark room, matrix aesthetic, cinematic lighting'},
          {'title': 'Neon Racer', 'platform': 'Stable Diffusion XL', 'description': 'Futuristic car driver', 'text': 'A person sitting in a futuristic neon car cockpit, glowing dashboard, wearing a tech-helmet with visor open, motion blur city lights outside window, high-end 3D render'},
          {'title': 'Cyber Bounty Hunter', 'platform': 'Midjourney', 'description': 'Rugged futuristic hunter', 'text': 'A person as a rugged cyberpunk bounty hunter, leather coat with neon trim, standing in a crowded futuristic market, cinematic smoke, atmospheric depth, highly detailed'},
          {'title': 'Android Evolution', 'platform': 'DALL-E 3', 'description': 'Half-human half-robot', 'text': 'A portrait of a person showing half human face and half mechanical android parts, glowing internal circuitry, white clean laboratory background, robotic aesthetic, sleek design'},
          {'title': 'Neon Pop Star', 'platform': 'Leonardo AI', 'description': 'Cyberpunk celebrity style', 'text': 'A person as a cyberpunk pop celebrity, glowing hair, holographic jewelry, stage lighting, vibrant colors, futuristic fashion photography style'},
          {'title': 'Skyline Infiltrator', 'platform': 'Gemini AI', 'description': 'Tactical roof-top agent', 'text': 'A person as a tactical agent on a skyscraper rooftop, futuristic binoculars, city skyline background, sunrise lighting, cinematic perspective, sharp details'},
          {'title': 'Cyberpunk Monk', 'platform': 'Adobe Firefly', 'description': 'Spiritual tech style', 'text': 'A person as a cyberpunk monk, traditional robes mixed with mechanical parts, meditating in a glowing digital garden, ethereal lighting, calm but futuristic vibe'},
        ];

      case 'Fantasy Warrior':
        return [
          {'title': 'Golden Knight', 'platform': 'Midjourney', 'description': 'Royal armor recreation', 'text': 'A person as a royal knight in heavy ornate golden armor, red velvet cape, standing in a castle courtyard, sunlight reflecting off metal, epic fantasy movie style, hyper-detailed'},
          {'title': 'Elven Archer', 'platform': 'DALL-E 3', 'description': 'Graceful fantasy style', 'text': 'A person as an elven archer, wearing green and silver leaf-patterned armor, holding a glowing bow, ancient mystical forest background, ethereal lighting, soft magical glow'},
          {'title': 'Dark Sorcerer', 'platform': 'Leonardo AI', 'description': 'Powerful magic user', 'text': 'A person as a dark sorcerer, flowing black robes with purple glow, holding a staff with a floating crystal, dark cave background with magical runes, moody dramatic lighting'},
          {'title': 'Viking Chieftain', 'platform': 'Flux AI', 'description': 'Rugged Norse warrior', 'text': 'A person as a powerful Viking chieftain, fur cloak, iron helmet, holding a battle axe, snowy mountain background, cinematic fog, rugged realistic texture'},
          {'title': 'Dragon Rider', 'platform': 'Stable Diffusion XL', 'description': 'Epic dragon master', 'text': 'A person as a dragon rider, wearing dragon-scale leather armor, standing next to a massive red dragon, volcanic background, orange glowing light, epic scale'},
          {'title': 'Paladin of Light', 'platform': 'Midjourney', 'description': 'Spiritual holy warrior', 'text': 'A person as a holy paladin, glowing white armor, blue energy swirling around, cathedral background, rays of light hitting the face, divine and powerful aesthetic'},
          {'title': 'Forest Ranger', 'platform': 'Adobe Firefly', 'description': 'Nature protector style', 'text': 'A person as a forest ranger, leather gear, wooden bow, companions with a wolf, sun-dappled forest background, natural colors, fantasy adventure style'},
          {'title': 'Barbarian Conqueror', 'platform': 'Gemini AI', 'description': 'Heavy muscle warrior', 'text': 'A person as a barbarian warrior, tribal tattoos, fur pelts, standing in a desert ruin, midday harsh sun, epic warrior pose, hyper-realistic'},
          {'title': 'Shadow Assassin', 'platform': 'DALL-E 3', 'description': 'Stealthy rogue style', 'text': 'A person as a shadow assassin, wearing a dark hooded mask, glowing daggers, moonlit rooftop background, high contrast shadows, mystery and action style'},
          {'title': 'Phoenix Mage', 'platform': 'Leonardo AI', 'description': 'Fire element magic', 'text': 'A person as a fire mage, fire wings appearing from back, orange glowing eyes, sparks flying, cinematic fire lighting, powerful fantasy art style'},
        ];

      case 'Esports Streamer':
        return [
          {'title': 'Pro Arena Setup', 'platform': 'Midjourney', 'description': 'Main stage streamer', 'text': 'A person sitting in a professional esports arena, large crowd in background blur, wearing a branded gaming jersey and pro headset, intense focus, blue and red stadium lighting, cinematic sports photography'},
          {'title': 'RGB Bedroom Vibe', 'platform': 'DALL-E 3', 'description': 'Cozy home stream', 'text': 'A person streaming from a cozy bedroom, colorful RGB nanoleaf lights on wall, dual monitor setup, gaming chair, soft purple and teal glow, aesthetic gaming lifestyle'},
          {'title': 'Victory Moment', 'platform': 'Leonardo AI', 'description': 'Winning celebration', 'text': 'A person cheering with arms up in front of a gaming PC, "Victory" text glowing on screen, confetti effect, bright enthusiastic lighting, high-quality stream capture style'},
          {'title': 'The Console Gamer', 'platform': 'Flux AI', 'description': 'Living room gaming', 'text': 'A person playing on a console, holding a controller, large OLED TV in background, cinematic living room interior, night time with subtle ambient lighting, cozy gaming vibes'},
          {'title': 'Mobile Pro Player', 'platform': 'Stable Diffusion XL', 'description': 'Competitive mobile gaming', 'text': 'A person focused on a high-end smartphone, gaming triggers attached, professional mobile esports jersey, neon tournament background, sharp focus on device and face'},
          {'title': 'Streaming Legend', 'platform': 'Gemini AI', 'description': 'Top-tier creator style', 'text': 'A person with a high-end Shure microphone, professional boom arm, softbox lighting hitting the face, blurred high-tech gaming room background, professional content creator aesthetic'},
          {'title': 'Esports Team Captain', 'platform': 'Adobe Firefly', 'description': 'Team leader portrait', 'text': 'A person as an esports team captain, standing with arms crossed, team logo on chest, cinematic dark background with spotlights, heroic and professional gaming stance'},
          {'title': 'Late Night Grinding', 'platform': 'Midjourney', 'description': 'Moody gaming session', 'text': 'A person gaming late at night, desk lamp and monitor glow, shadows on face, empty energy drink cans, realistic messy desk, cinematic moody atmosphere'},
          {'title': 'Retro Game Stream', 'platform': 'DALL-E 3', 'description': 'Old-school gaming vibe', 'text': 'A person playing an old arcade machine, pixel art reflecting on face, retro 80s neon aesthetic, arcade room background, nostalgic and vibrant'},
          {'title': 'VR Explorer', 'platform': 'Leonardo AI', 'description': 'Virtual reality gaming', 'text': 'A person wearing a high-tech VR headset, hands reaching out to glowing digital particles, futuristic clean room, sci-fi gaming atmosphere, blue holographic lighting'},
        ];

      case 'GTA Style Avatar':
        return [
          {'title': 'Vice City Vibe', 'platform': 'Midjourney', 'description': '80s neon GTA style', 'text': 'A person recreated in the GTA Vice City art style, wearing a pink suit, neon sunset background, tropical palm trees, bold ink outlines, vibrant hand-painted aesthetic'},
          {'title': 'San Andreas Gangster', 'platform': 'DALL-E 3', 'description': 'Urban street style', 'text': 'A person in GTA San Andreas loading screen art style, wearing a bandana and gold chain, urban street background with graffiti, high contrast cel-shading, cool confident pose'},
          {'title': 'Los Santos Luxury', 'platform': 'Leonardo AI', 'description': 'Modern GTA V style', 'text': 'A person in GTA V art style, standing next to a luxury sports car, mansion in background, bold saturated colors, comic-book style shading, cinematic action vibe'},
          {'title': 'Biker Outlaw', 'platform': 'Flux AI', 'description': 'Harley-style GTA art', 'text': 'A person as a GTA outlaw biker, leather vest, tattoos, holding a helmet, desert highway background, rugged oil painting style with thick outlines'},
          {'title': 'The Heist Leader', 'platform': 'Stable Diffusion XL', 'description': 'Action-packed GTA style', 'text': 'A person in GTA style, wearing a tactical mask and suit, holding a duffel bag of cash, city bank background, cinematic loading screen art, high energy'},
          {'title': 'Beachside Hustler', 'platform': 'Gemini AI', 'description': 'Summer GTA aesthetic', 'text': 'A person in GTA loading screen style, wearing sunglasses and a tropical shirt, beach background with a yacht, bright sunny colors, stylized digital illustration'},
          {'title': 'Underground Racer', 'platform': 'Adobe Firefly', 'description': 'Fast and furious GTA', 'text': 'A person in GTA style, leaning against a modified tuner car, neon street racing background, sharp shadows, vibrant night colors, iconic game art style'},
          {'title': 'The Mafia Boss', 'platform': 'Midjourney', 'description': 'Sophisticated crime style', 'text': 'A person as a GTA mafia boss, expensive suit, cigar, dark office background, dramatic lighting, bold stylized lines, classic Rockstar Games aesthetic'},
          {'title': 'Hacker Rogue', 'platform': 'DALL-E 3', 'description': 'Tech-focused GTA art', 'text': 'A person as a GTA tech-hacker, wearing a hoodie and headphones, multiple laptop screens in background, green and black aesthetic, stylized vector art'},
          {'title': 'Desert Wanderer', 'platform': 'Leonardo AI', 'description': 'Red Dead style GTA', 'text': 'A person in a western-themed GTA style, cowboy hat, rugged clothes, dusty canyon background, sepia and orange tones, hand-drawn game art aesthetic'},
        ];

      case '3D Game Character':
        return [
          {'title': 'Pixar Style Hero', 'platform': 'Midjourney', 'description': 'Cute 3D animation style', 'text': 'A person as a 3D animated character, Pixar Disney style, big expressive eyes, smooth stylized skin, wearing a colorful adventure outfit, bright friendly lighting, octane render'},
          {'title': 'Overwatch Agent', 'platform': 'DALL-E 3', 'description': 'Stylized hero shooter style', 'text': 'A person as an Overwatch game character, heroic armor, holding a futuristic gadget, vibrant colors, stylized Blizzard-style 3D art, cinematic game pose'},
          {'title': 'Fortnite Skin', 'platform': 'Leonardo AI', 'description': 'Battle royale character', 'text': 'A person as a Fortnite character skin, tactical gear with pickaxe on back, vibrant cel-shaded 3D look, playful emote pose, clean colorful background, Unreal Engine 5 render'},
          {'title': 'Final Fantasy Hero', 'platform': 'Flux AI', 'description': 'JRPG 3D aesthetic', 'text': 'A person as a Final Fantasy character, spikey hair, intricate ornamental armor, glowing magical sword, beautiful semi-realistic 3D face, cinematic fantasy lighting'},
          {'title': 'League Splash Art', 'platform': 'Stable Diffusion XL', 'description': 'Epic MOBA 3D art', 'text': 'A person as a League of Legends champion, epic dynamic pose, magical energy effects, highly detailed 3D digital painting, fantasy background, cinematic masterpiece'},
          {'title': 'Mobile RPG Avatar', 'platform': 'Gemini AI', 'description': 'Cute fantasy 3D', 'text': 'A person as a 3D mobile RPG character, chibi-style proportions, holding a staff, floating pets, bright saturated colors, soft 3D modeling style'},
          {'title': 'Sci-Fi Soldier', 'platform': 'Adobe Firefly', 'description': 'Halo/Destiny style', 'text': 'A person as a sci-fi super soldier, heavy mechanical armor, glowing visor, standing on an alien planet, high-end 3D game asset style, realistic textures'},
          {'title': 'Horror Game Protagonist', 'platform': 'Midjourney', 'description': 'Resident Evil style', 'text': 'A person as a survival horror game character, holding a flashlight, sweating, detailed realistic 3D skin, dark mansion hallway background, cinematic suspense lighting'},
          {'title': 'Street Fighter Pro', 'platform': 'DALL-E 3', 'description': 'Fighting game style', 'text': 'A person as a 3D fighting game character, muscular build, martial arts pose, ink-splash effects around hands, stylized 3D render, vibrant energy'},
          {'title': 'Cyber-Ninjas', 'platform': 'Leonardo AI', 'description': 'Genji-style 3D art', 'text': 'A person as a 3D cyber-ninja, sleek black armor with green lights, acrobatic pose, futuristic city roof background, sharp 3D edges, cinematic game render'},
        ];

      case 'Superhero Suit':
        return [
          {'title': 'Iron Avenger', 'platform': 'Midjourney', 'description': 'High-tech nano armor', 'text': 'A person wearing a high-tech nano-tech superhero suit, glowing circular core on chest, metallic red and gold finish, standing in a futuristic lab, cinematic Marvel style, 8k resolution'},
          {'title': 'Caped Crusader', 'platform': 'DALL-E 3', 'description': 'Dark knight style', 'text': 'A person as a dark superhero, heavy black tactical armor, long flowing cape, standing on a rainy rooftop, bat-signal in the distance, moody cinematic lighting'},
          {'title': 'Cosmic Goddess', 'platform': 'Leonardo AI', 'description': 'Space power style', 'text': 'A person as a cosmic superhero, suit made of stars and nebulae, glowing eyes, flying through space, vibrant galaxy background, ethereal and powerful lighting'},
          {'title': 'Speedster Flash', 'platform': 'Flux AI', 'description': 'Electrical speed style', 'text': 'A person as a speedster superhero, red sleek suit, yellow lightning bolts crackling around the body, motion blur effect, urban street background, high energy'},
          {'title': 'Amazonian Warrior', 'platform': 'Stable Diffusion XL', 'description': 'Wonder woman style', 'text': 'A person as an Amazonian superhero, bronze eagle armor, glowing lasso, holding a shield, ancient temple background, powerful heroic stance, cinematic lighting'},
          {'title': 'Tactical Spy Hero', 'platform': 'Gemini AI', 'description': 'Black widow style', 'text': 'A person as a tactical superhero spy, sleek black leather stealth suit, gadgets on belt, glowing blue batons, dark warehouse background, action movie aesthetic'},
          {'title': 'Nature Guardian', 'platform': 'Adobe Firefly', 'description': 'Elemental plant power', 'text': 'A person as a nature-based superhero, suit made of glowing vines and leaves, controlling green energy, forest background, organic and magical superhero style'},
          {'title': 'Spider-Verse Hero', 'platform': 'Midjourney', 'description': 'Stylized spider suit', 'text': 'A person as a spider-themed superhero, unique custom suit design, swinging between buildings, comic book half-tone dots effect, vibrant colors, stylized action pose'},
          {'title': 'Winter Soldier', 'platform': 'DALL-E 3', 'description': 'Cybernetic arm hero', 'text': 'A person as a super-soldier, metallic silver mechanical arm, tactical military gear, snowy mountain background, gritty realistic superhero style, cinematic'},
          {'title': 'Magic Sorceress', 'platform': 'Leonardo AI', 'description': 'Scarlet witch style', 'text': 'A person as a magical superhero, flowing red robes, red energy hexes in hands, floating in air, dark mystical background, cinematic magical lighting'},
        ];

      default:
        return [];
    }
  }
}
