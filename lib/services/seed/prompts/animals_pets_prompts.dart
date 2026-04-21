// lib/services/seed/prompts/animals_pets_prompts.dart

class AnimalsPetsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {

      case 'Dogs Puppies':
        return [
          {'title': 'Golden Retriever Hero', 'platform': 'Midjourney', 'description': 'Golden retriever running in meadow', 'text': 'Golden retriever dog running through green meadow, sunlight on fur, tongue out, joy and energy, shallow depth of field, bokeh background, professional pet photography, ultra realistic'},
          {'title': 'Sleepy Puppy Pile', 'platform': 'DALL-E 3', 'description': 'Pile of puppies in basket', 'text': 'Adorable pile of Labrador puppies sleeping together in wicker basket, soft blanket, warm golden light, fluffy fur detail, ultra cute newborn puppy photography, heartwarming'},
          {'title': 'Indian Spitz Portrait', 'platform': 'Leonardo AI', 'description': 'Regal Indian Spitz close-up', 'text': 'Regal Indian Spitz dog portrait, fluffy white coat, bright intelligent eyes, white studio background, professional pet photography, sharp fur detail, elegant dignified pose'},
          {'title': 'Street Dog Dignity', 'platform': 'Stable Diffusion XL', 'description': 'Indie dog noble portrait', 'text': 'Noble Indian street dog sitting proudly at golden hour, warm backlight, bokeh street background, emotional dignified portrait celebrating indie dogs, photorealistic'},
          {'title': 'Puppy First Snow', 'platform': 'Gemini AI', 'description': 'Puppy experiencing snow', 'text': 'Tiny puppy touching snow for first time, confused adorable expression, snowflakes on nose, cold breath visible, heartwarming candid moment, professional pet photography'},
          {'title': 'Indian Breed Poster', 'platform': 'Adobe Firefly', 'description': 'Indian dog breeds showcase', 'text': 'Beautiful illustrated poster of Indian dog breeds, Rajapalayam Mudhol Hound Chippiparai Kombai and Kanni, white studio background, breed showcase educational poster art'},
          {'title': 'Husky Ice Eyes', 'platform': 'Midjourney', 'description': 'Husky with blue eyes close-up', 'text': 'Siberian Husky extreme close-up portrait, piercing icy blue heterochromia eyes, thick fur detail, snowy bokeh background, dramatic lighting, National Geographic dog photography quality'},
          {'title': 'Dachshund Sticker Art', 'platform': 'Flux AI', 'description': 'Cute dachshund illustration', 'text': 'Adorable cartoon dachshund with tiny legs and oversized floppy ears, big puppy eyes, flat vector illustration style, pastel background, cute dog sticker design art'},
          {'title': 'Dog Water Splash', 'platform': 'DALL-E 3', 'description': 'Dog leaping into lake', 'text': 'Labrador leaping into lake with explosive water splash frozen in high speed photography, pure joy expression, droplets catching sunlight, action pet photography masterpiece'},
          {'title': 'Old Dog Wisdom', 'platform': 'Leonardo AI', 'description': 'Senior dog emotional portrait', 'text': 'Dignified senior Labrador portrait, grey muzzle, wise and gentle eyes, warm studio lighting, emotionally rich and beautiful pet photography, celebrating older dogs'},
        ];

      case 'Cats Kittens':
        return [
          {'title': 'Persian Cat Elegance', 'platform': 'Midjourney', 'description': 'Persian cat regal portrait', 'text': 'Elegant Persian cat sitting on velvet chair, long silky coat perfectly groomed, regal posture, soft studio lighting, professional cat portrait photography, ultra realistic fur detail'},
          {'title': 'Kitten Window Glow', 'platform': 'DALL-E 3', 'description': 'Kitten in golden window light', 'text': 'Tiny tabby kitten sitting in window bathed in golden morning light, dust particles floating, soft bokeh background, peaceful atmosphere, emotional lifestyle pet photography'},
          {'title': 'Street Cat Portrait', 'platform': 'Leonardo AI', 'description': 'Indian street cat portrait', 'text': 'Beautiful Indian street cat on colorful painted wall, peeling paint background, intelligent amber eyes, documentary style pet photography, photorealistic powerful portrait'},
          {'title': 'Cat Eye Galaxy Macro', 'platform': 'Stable Diffusion XL', 'description': 'Extreme cat eye close-up', 'text': 'Extreme macro close-up of cat eye, vertical slit pupil, iris patterns resembling a galaxy, every detail tack sharp, mysterious and beautiful, fine art macro photography'},
          {'title': 'Watercolor Kitten Art', 'platform': 'Gemini AI', 'description': 'Watercolor kittens illustration', 'text': 'Soft watercolor illustration of three kittens in wicker basket, pastel pink and cream tones, loose artistic brush strokes, white paper showing through, nursery wall art'},
          {'title': 'Cat Yoga Stickers', 'platform': 'Adobe Firefly', 'description': 'Cat in funny yoga positions', 'text': 'Funny cat doing impossible yoga poses, flat cartoon illustration style, multiple poses on single sticker sheet, humorous expressions, pastel background, cute social media art'},
          {'title': 'Bengal Wild Spirit', 'platform': 'Midjourney', 'description': 'Bengal cat wild look', 'text': 'Bengal cat with wild leopard-like rosette spots crouching on log, predator stare, dappled forest light, wild feline energy, dramatic wildlife-style photography'},
          {'title': 'Cartoon Cat Character', 'platform': 'Flux AI', 'description': 'Cute cat character design', 'text': 'Cute cartoon cat character design with huge sparkling eyes and tiny nose, multiple expressions reference sheet, kawaii anime style, soft pastel colors, character concept art'},
          {'title': 'Cat Monsoon Window', 'platform': 'DALL-E 3', 'description': 'Cat watching monsoon rain', 'text': 'Cat sitting on windowsill watching heavy monsoon rain, paw on glass, melancholic beautiful atmosphere, raindrops in sharp focus, warm interior bokeh, cinematic pet moment'},
          {'title': 'Kitten Marigold Garden', 'platform': 'Leonardo AI', 'description': 'Kitten among marigolds', 'text': 'Fluffy white kitten nestled among bright orange marigold flowers in Indian garden, natural soft light, flower bokeh background, spring freshness, adorable lifestyle pet photography'},
        ];

      case 'Birds':
        return [
          {'title': 'Kingfisher Strike Dive', 'platform': 'Midjourney', 'description': 'Kingfisher catching fish', 'text': 'Indian common kingfisher diving into river at lightning speed, small fish in beak, water explosion frozen in time, vivid blue-orange plumage, high speed action bird photography masterpiece'},
          {'title': 'Peacock Full Display', 'platform': 'DALL-E 3', 'description': 'Peacock fanning tail feathers', 'text': 'Indian peacock spreading magnificent full tail feather display, every iridescent eye pattern detailed perfectly, garden setting, dramatic low angle shot, stunning national bird portrait'},
          {'title': 'Flamingo Pink Sea', 'platform': 'Leonardo AI', 'description': 'Flamingo flock at sunrise', 'text': 'Thousands of flamingos at Sambhar Lake Rajasthan, pink sea of birds as far as eye can see, misty sunrise light, perfect reflections in still water, National Geographic bird photography'},
          {'title': 'Hornbill Close-up', 'platform': 'Stable Diffusion XL', 'description': 'Great hornbill portrait', 'text': 'Great Indian Hornbill extreme close-up portrait, massive yellow casque bill, striking black and white plumage, forest background, sharp eye detail, stunning exotic bird photography'},
          {'title': 'Owl Moonlit Hunter', 'platform': 'Gemini AI', 'description': 'Owl with glowing eyes at night', 'text': 'Indian spotted owl perched on branch at night, enormous glowing amber eyes, silent hunter pose, moonlight rim lighting, atmospheric mysterious bird portrait photography'},
          {'title': 'Sunbird Nectar Feed', 'platform': 'Adobe Firefly', 'description': 'Sunbird hovering at flower', 'text': 'Purple sunbird hovering at red hibiscus flower sipping nectar, iridescent plumage catching light, wings blurred in motion, macro close focus, colorful precise bird photography'},
          {'title': 'Eagle Sky Soar', 'platform': 'Midjourney', 'description': 'Eagle soaring against blue sky', 'text': 'Indian eagle soaring against dramatic blue sky, wings fully spread, primary feathers splayed against clouds, majestic power and freedom, wildlife photography from dramatic below angle'},
          {'title': 'Parakeet Tree Burst', 'platform': 'Flux AI', 'description': 'Parakeets taking flight', 'text': 'Explosive burst of Indian ring-neck parakeets taking flight from banyan tree, hundreds of green birds, motion and chaos, golden backlight, dramatic flock bird photography'},
          {'title': 'Crane Migration Sunset', 'platform': 'DALL-E 3', 'description': 'Cranes in V-formation', 'text': 'Thousands of Demoiselle cranes migrating in V-formation over Rajasthan, dramatic orange sunset sky, immense natural scale, wildlife migration spectacle photography'},
          {'title': 'Egret Zen Reflection', 'platform': 'Leonardo AI', 'description': 'Egret in still water', 'text': 'Great white egret standing perfectly still in misty water, flawless mirror reflection below, one leg raised, minimalist zen composition, fine art nature photography'},
        ];

      case 'Wildlife':
        return [
          {'title': 'Bengal Tiger Stalk', 'platform': 'Midjourney', 'description': 'Tiger walking through jungle', 'text': 'Royal Bengal tiger walking through dense jungle, golden sunlight filtering through canopy, intense amber eyes focused on camera, water droplets on whiskers, National Geographic quality wildlife photography'},
          {'title': 'Snow Leopard Rocky', 'platform': 'DALL-E 3', 'description': 'Snow leopard on Himalayan rock', 'text': 'Rare snow leopard resting on rocky Himalayan ledge, piercing pale blue eyes, spotted fur in perfect detail, snowy mountain backdrop, BBC Earth documentary quality wildlife portrait'},
          {'title': 'Elephant River Herd', 'platform': 'Leonardo AI', 'description': 'Elephant herd crossing river', 'text': 'Wild Indian elephant herd crossing river at golden sunset, mother guiding baby elephant, warm light on wet skin, dust particles in backlight, cinematic wildlife photography masterpiece'},
          {'title': 'Rhino Kaziranga Mist', 'platform': 'Stable Diffusion XL', 'description': 'Rhino in morning mist', 'text': 'Greater one-horned rhinoceros emerging from tall elephant grass in misty Kaziranga morning, armored textured skin, conservation photography, powerful endangered species portrait'},
          {'title': 'Leopard Night Eyes', 'platform': 'Gemini AI', 'description': 'Leopard emerging from darkness', 'text': 'Indian leopard staring from darkness, eyes glowing eerily in flash light, spots visible in deep shadow, terrifyingly beautiful, dramatic wildlife night photography'},
          {'title': 'King Cobra Spread', 'platform': 'Adobe Firefly', 'description': 'King cobra hood fully open', 'text': 'King cobra raised with full hood dramatically spread, scales glistening with iridescence, forest floor background, eye level macro close-up, dangerous beauty, wildlife photography'},
          {'title': 'Asiatic Lion Gir', 'platform': 'Midjourney', 'description': 'Gir lions at sunset', 'text': 'Asiatic lion pride in Gir forest at golden sunset, dominant male with full mane, lionesses resting nearby, warm amber light across landscape, cinematic wildlife photography'},
          {'title': 'Gharial Chambal Bank', 'platform': 'Flux AI', 'description': 'Gharial on river bank', 'text': 'Critically endangered gharial crocodile basking on Chambal river sandbank, long distinctive snout, scales in extreme detail, conservation wildlife photography, documentary quality image'},
          {'title': 'Sloth Bear Cubs Ride', 'platform': 'DALL-E 3', 'description': 'Mother bear with cubs on back', 'text': 'Sloth bear mother with two fluffy cubs riding on her back through jungle, rare behavioral moment, warm forest light, conservation wildlife story photography'},
          {'title': 'Nilgai Dawn Graze', 'platform': 'Leonardo AI', 'description': 'Nilgai in morning mist', 'text': 'Large Nilgai blue bull grazing at misty Indian sunrise, dew on golden grassland, morning light catching blue-grey coat, serene wildlife photography in open landscape'},
        ];

      case 'Pet Portraits':
        return [
          {'title': 'Royal Dog Oil Portrait', 'platform': 'Midjourney', 'description': 'Dog in classical oil portrait', 'text': 'Regal Indian Spitz dog painted in classical oil portrait style, royal red velvet background, ornate gold collar, sitting proudly on throne, museum quality old master pet portrait'},
          {'title': 'Cat Watercolor Art', 'platform': 'DALL-E 3', 'description': 'Cat in watercolor style', 'text': 'Beautiful watercolor portrait of Persian cat, soft wet-on-wet washes forming fur, color splashes and drips, white paper showing through, contemporary loose watercolor pet art'},
          {'title': 'Dog Superhero Poster', 'platform': 'Leonardo AI', 'description': 'Pet dog as superhero', 'text': 'Golden Retriever dog as superhero wearing flowing red cape, dramatic stormy sky background, heroic confident pose, digital art composite, fun epic pet portrait concept art'},
          {'title': 'Rabbit Flower Portrait', 'platform': 'Stable Diffusion XL', 'description': 'Bunny portrait in garden', 'text': 'Fluffy white rabbit portrait nestled among bright marigold flowers in Indian garden, natural soft light, bokeh flower background, spring warmth, lifestyle pet photography'},
          {'title': 'Parrot Jungle King', 'platform': 'Gemini AI', 'description': 'Indian parrot dramatic portrait', 'text': 'Indian ring-neck parakeet extreme close-up portrait, vivid green feathers with red beak sharp, confident assertive stare, natural jungle light, colorful dramatic bird portrait'},
          {'title': 'Hamster Tiny World', 'platform': 'Adobe Firefly', 'description': 'Hamster in miniature scene', 'text': 'Tiny hamster sitting in miniature living room with matchbox furniture, holding tiny popcorn, cinematic tiny world macro composite photography, incredibly detailed pet portrait'},
          {'title': 'Betta Fish Fine Art', 'platform': 'Midjourney', 'description': 'Betta fish portrait', 'text': 'Beautiful Betta fish in planted aquarium, vibrant red silk fins spread gracefully, underwater macro photography, aquatic plant bokeh background, dramatic lighting fish portrait'},
          {'title': 'Tortoise Wisdom Portrait', 'platform': 'Flux AI', 'description': 'Indian star tortoise close-up', 'text': 'Close-up portrait of ancient Indian star tortoise, wise old eyes, intricate geometric star shell pattern detail, moss-covered rock, dramatic side lighting, fine art reptile portrait'},
          {'title': 'Puppy Homecoming Story', 'platform': 'DALL-E 3', 'description': 'Puppy first day at home', 'text': 'Tiny puppy on first day at new home, overwhelmed exploring with wonder, warm hardwood floor, family home background, candid lifestyle pet photography, heartwarming story'},
          {'title': 'Cat Astronaut Space', 'platform': 'Leonardo AI', 'description': 'Cat in space suit illustration', 'text': 'Cute cartoon cat wearing full astronaut suit floating in outer space, stars and planets background, funny imaginative pet illustration, digital art style, social media worthy design'},
        ];

      case 'Cute Animals':
        return [
          {'title': 'Baby Animals Nursery', 'platform': 'Midjourney', 'description': 'Baby animals nursery illustration', 'text': 'Adorable nursery illustration of Indian baby animals, baby elephant tiger peacock and deer all together, soft pastel colors, round cute chubby shapes, childrens book illustration style'},
          {'title': 'Elephant Artist Painter', 'platform': 'DALL-E 3', 'description': 'Baby elephant holding paintbrush', 'text': 'Cute baby elephant holding paintbrush with tiny trunk, painting colorful canvas, beret hat on head, art studio setting, whimsical childrens illustration, warm cheerful pastel colors'},
          {'title': 'Animal Music Band', 'platform': 'Leonardo AI', 'description': 'Indian animals playing music', 'text': 'Cute Indian animals playing music together, monkey on tabla, peacock on flute, elephant on dhol, tiger on sitar, colorful cartoon band illustration, fun whimsical art style'},
          {'title': 'Monsoon Frog Umbrella', 'platform': 'Stable Diffusion XL', 'description': 'Frog with tiny umbrella', 'text': 'Super cute cartoon frog sitting on lily pad in Indian monsoon rain, holding tiny colorful umbrella, rain drops on leaves, pond background, adorable kawaii nature art'},
          {'title': 'Cheeky Squirrel Snack', 'platform': 'Gemini AI', 'description': 'Squirrel with puffed cheeks', 'text': 'Adorable Indian palm squirrel with massively puffed cheeks full of nuts, huge round eyes, fluffy striped tail curled up, tree branch setting, detailed cute nature illustration'},
          {'title': 'Animal Diwali Party', 'platform': 'Adobe Firefly', 'description': 'Animals celebrating Diwali', 'text': 'Cute Indian animals celebrating Diwali together, elephant lighting diyas, peacock twirling sparkler, monkey distributing sweets, warm festival orange and gold colors, children illustration'},
          {'title': 'Tiny Animals Sleepover', 'platform': 'Midjourney', 'description': 'Baby animals sleeping together', 'text': 'Precious pile of sleeping baby animals, puppy kitten bunny duckling and piglet all cuddled together, cozy soft blanket, pastel nursery atmosphere, ultra kawaii illustration art'},
          {'title': 'Dancing Cow Village', 'platform': 'Flux AI', 'description': 'Happy cow cartoon', 'text': 'Happy cartoon cow wearing bright flower garland, big sparkly eyes, colorful Indian village background, joyfully dancing pose, cute flat vector illustration, Amul-inspired cheerful art'},
          {'title': 'Animal School Classroom', 'platform': 'DALL-E 3', 'description': 'Animals in a classroom', 'text': 'Cartoon Indian animals in school classroom, wise owl teacher at blackboard, student animals include tiny elephant tiger monkey and deer in school uniforms, cute educational illustration'},
          {'title': 'Panda Chef Curry', 'platform': 'Leonardo AI', 'description': 'Panda cooking Indian food', 'text': 'Adorable chubby panda chef stirring giant pot of Indian curry, chef hat and apron, wooden spoon, steam and colorful spices swirling, kitchen setting, super cute food and animal art'},
        ];

      default:
        return [];
    }
  }
}
