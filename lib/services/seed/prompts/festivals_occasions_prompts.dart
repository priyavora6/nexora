// lib/services/seed/prompts/festivals_occasions_prompts.dart

class FestivalsOccasionsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Diwali':
        return [
          {
            'title': 'The Diwali Saree Look',
            'platform': 'Midjourney',
            'description': 'Convert your photo into a festive Diwali look',
            'text': 'Transform the woman in this photo into a festive Diwali scene. Change her outfit to a heavy silk Banarasi saree with gold jewelry and a bindi. Set the background to a beautifully decorated balcony with hundreds of glowing oil diyas and marigold garlands. Maintain her exact face and smile.',
            'isFeatured': 'true',
          },
          {
            'title': 'Sparkler Night Portrait',
            'platform': 'Leonardo AI',
            'description': 'Add glowing sparklers to your photo',
            'text': 'Modify this photo to show the person holding a glowing Diwali sparkler (Phuljhadi). Add warm light reflections on their face from the sparks. The background should be a night scene with blurred decorative lights (bokeh). Maintain the original facial features and expression.',
            'isFeatured': 'false',
          },
          {
            'title': 'Traditional Diya Pose',
            'platform': 'DALL-E 3',
            'description': 'You holding a traditional clay lamp',
            'text': 'Recreate this photo showing the person cupping a lit clay diya in their hands. Change their clothes to traditional Indian ethnic wear. Add a warm golden glow to the skin. The background should be an elegant Indian home interior during Diwali. Keep the face recognizable.',
            'isFeatured': 'false',
          },
          {
            'title': 'Diwali Family Reunion',
            'platform': 'Midjourney',
            'description': 'Turn a family photo into a Diwali card',
            'text': 'Transform this family group photo into a Diwali celebration. Change everyone’s clothing to coordinated festive silk outfits. Add a large Rangoli on the floor in front of them and hanging lanterns above. Warm, joyful atmosphere. Maintain the faces of all family members.',
            'isFeatured': 'true',
          },
          {
            'title': 'The Royal Diwali Feast',
            'platform': 'Stable Diffusion XL',
            'description': 'See yourself at a luxury Diwali dinner',
            'text': 'Take the person from this photo and place them at a lavishly set Diwali dinner table with silver thalis and sweets. Use warm candlelight. Change their background to a grand heritage dining hall. Maintain the facial identity perfectly.',
            'isFeatured': 'false',
          },
          {
            'title': 'Sky Lantern Release',
            'platform': 'Midjourney',
            'description': 'Releasing a lantern into the night sky',
            'text': 'Transform this photo to show the person releasing a glowing paper sky lantern into a dark night sky filled with thousands of other lanterns. The person’s face should be lit by the warm glow of the lantern. Maintain face features.',
            'isFeatured': 'false',
          },
          {
            'title': 'Diwali Gold & Silk',
            'platform': 'Leonardo AI',
            'description': 'Focus on heavy jewelry and silk',
            'text': 'Recreate this portrait with a focus on luxury. Change the person\'s outfit to a premium gold-embroidered sherwani or lehenga. Add heavy traditional kundan jewelry. Background is an opulent palace room lit by diyas. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Rangoli Artist Pose',
            'platform': 'DALL-E 3',
            'description': 'You making a beautiful rangoli',
            'text': 'Modify this photo to show the person sitting on the floor, finishing a giant, colorful flower rangoli. Their hands should have a bit of color powder. Festive lighting, traditional home setting. Keep the person’s original face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Diwali Firework Background',
            'platform': 'Stable Diffusion XL',
            'description': 'Epic fireworks behind you',
            'text': 'Take the person from this photo and place them on a rooftop at night. The sky behind them should be exploding with colorful professional fireworks. The person should look excited. Maintain face and hair style.',
            'isFeatured': 'false',
          },
          {
            'title': 'Pixar Style Diwali',
            'platform': 'Midjourney',
            'description': 'Turn yourself into a 3D Diwali character',
            'text': 'Convert the person in this photo into a high-quality 3D Disney-Pixar style character celebrating Diwali. They should be holding a sweet box. Soft 3D rendering, vibrant colors, festive background. Maintain recognizable features.',
            'isFeatured': 'false',
          },
        ];

      case 'Holi':
        return [
          {
            'title': 'Holi Color Splash',
            'platform': 'Midjourney',
            'description': 'Add Holi colors to your face and clothes',
            'text': 'Transform this photo into a Holi festival scene. Add vibrant splashes of organic pink, yellow, and green colors (Gulal) to the person’s face, hair, and white clothes. The background should be a joyful outdoor crowd throwing colors. Keep the person’s original face.',
            'isFeatured': 'true',
          },
          {
            'title': 'The Clean White Kurta',
            'platform': 'Leonardo AI',
            'description': 'The classic "Before Holi" look',
            'text': 'Change the person\'s outfit in this photo to a crisp, high-quality white Lucknowi Chikankari kurta. The background should be a sunny Indian garden with a small plate of colors nearby. Professional lifestyle photography. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Holi Rain Dance',
            'platform': 'DALL-E 3',
            'description': 'Move your photo to a pool party',
            'text': 'Modify this photo to show the person at a Holi rain dance party. Add realistic water splashes and wet hair effects. They should be wearing a colorful Holi t-shirt and sunglasses. Sunlit festive atmosphere. Maintain the original face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Radha-Krishna Theme',
            'platform': 'Midjourney',
            'description': 'A mythological makeover',
            'text': 'Recreate this portrait in the style of a traditional mythological painting. The person should look like a character from ancient Indian stories, covered in flower petals and soft colors. Artistic, painterly style. Keep face recognizable.',
            'isFeatured': 'true',
          },
          {
            'title': 'Holi Color Smoke',
            'platform': 'Stable Diffusion XL',
            'description': 'Epic smoke bomb effect',
            'text': 'Take the person from this photo and surround them with thick, vibrant clouds of orange and blue Holi smoke. The person should have a cool, confident expression. Cinematic lighting, street style. Maintain face identity.',
            'isFeatured': 'false',
          },
          {
            'title': 'Pichkari Action Shot',
            'platform': 'Leonardo AI',
            'description': 'You holding a water gun',
            'text': 'Transform this photo to show the person playfully aiming a traditional brass water gun (Pichkari) at the camera. Add water droplets on the lens and a colorful, messy background. Joyful and energetic. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Floral Holi Portrait',
            'platform': 'Midjourney',
            'description': 'Holi with flower petals',
            'text': 'Modify this photo to replace gulal colors with a rain of vibrant marigold and rose petals. The person should look peaceful and happy. Soft, warm morning sunlight. Maintain the person’s original features.',
            'isFeatured': 'false',
          },
          {
            'title': 'Holi Best Friends',
            'platform': 'DALL-E 3',
            'description': 'Perfect for group photos',
            'text': 'Transform this group photo into a Holi celebration. Add varied color stains to everyone’s clothes and faces. Place them in a neighborhood street celebration with music and dancing. Maintain all facial identities.',
            'isFeatured': 'false',
          },
          {
            'title': 'Watercolor Holi Art',
            'platform': 'Adobe Firefly',
            'description': 'Turn your photo into a painting',
            'text': 'Convert this photo into a vibrant watercolor painting. Use splashes of "Holi" colors to define the shapes. The person’s face should be an artistic representation but still clearly them. Messy, creative art style.',
            'isFeatured': 'false',
          },
          {
            'title': 'Post-Holi Candid',
            'platform': 'Midjourney',
            'description': 'The exhausted but happy look',
            'text': 'Modify this photo to show the person after a long day of Holi. Face completely covered in mixed colors, wet hair, holding a glass of Thandai. Soft evening light, highly realistic and candid. Maintain face.',
            'isFeatured': 'false',
          },
        ];

      case 'Eid':
        return [
          {
            'title': 'The Royal Eid Sherwani',
            'platform': 'Midjourney',
            'description': 'Transform your photo into a royal Eid look',
            'text': 'Transform the man in this photo into a regal Eid scene. Change his outfit to a heavy embroidered ivory Sherwani with a silk stole. Set the background to a grand Mughal-style archway at sunrise. Maintain his exact face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Elegant Eid Anarkali',
            'platform': 'Leonardo AI',
            'description': 'Beautiful traditional makeover',
            'text': 'Change the woman\'s outfit in this photo to a designer floor-length Anarkali suit with heavy zari work. Add an elegant dupatta over one shoulder and traditional jewelry. Background is a festive home with lanterns. Maintain face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Eid Mubarak Greeting',
            'platform': 'DALL-E 3',
            'description': 'Create a professional greeting card',
            'text': 'Take the person from this photo and place them in a peaceful Eid morning setting. They should be holding their hands in a "Dua" or greeting pose. Add "Eid Mubarak" text in the background in gold calligraphy. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'The Eid Feast',
            'platform': 'Midjourney',
            'description': 'You at a traditional dinner table',
            'text': 'Recreate this photo showing the person sitting at a lavish Eid dinner table filled with Biryani, Kebabs, and Seviyan. Use warm, inviting lighting. The person should be wearing festive silk clothes. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Crescent Moon Night',
            'platform': 'Stable Diffusion XL',
            'description': 'Magical night-sky theme',
            'text': 'Modify this photo to show the person on a balcony looking at a giant, glowing crescent moon in a starry sky. Add a peaceful, spiritual atmosphere. The person should be in formal ethnic wear. Maintain face identity.',
            'isFeatured': 'false',
          },
          {
            'title': 'Henna Hands Focus',
            'platform': 'Leonardo AI',
            'description': 'Highlighting your mehendi',
            'text': 'Take the person from this photo and focus on their hands which should now have intricate, dark Eid mehendi designs. The person should be smiling in the background. Soft focus, warm festive lighting. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Eid with Friends',
            'platform': 'Midjourney',
            'description': 'A celebratory group transformation',
            'text': 'Transform this photo of friends into an Eid celebration. Everyone should be in premium ethnic wear, embracing and laughing. Set the background to a decorated garden party at night. Maintain all faces.',
            'isFeatured': 'false',
          },
          {
            'title': 'Grand Mosque Visit',
            'platform': 'DALL-E 3',
            'description': 'Place yourself at a famous mosque',
            'text': 'Take the person from this photo and place them in the courtyard of a magnificent grand mosque with white marble and minarets. The lighting should be soft morning light. Dignified and graceful. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Child’s First Eid',
            'platform': 'Leonardo AI',
            'description': 'Cute traditional kid makeover',
            'text': 'Transform the child in this photo into a cute Eid look. Add a small skullcap (topi) for boys or a small lehenga for girls. They should be holding "Eidi" (money) and smiling. Background is a festive room. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Modern Indo-Western Eid',
            'platform': 'Flux AI',
            'description': 'Trendy and stylish Eid look',
            'text': 'Recreate this photo with a modern Eid fashion vibe. Change the outfit to a trendy Indo-western suit. Use high-fashion editorial lighting and a minimalist aesthetic background. Maintain the person\'s identity.',
            'isFeatured': 'false',
          },
        ];

      case 'Christmas':
        return [
          {
            'title': 'Cozy Sweater Morning',
            'platform': 'Midjourney',
            'description': 'Transform into a cozy Christmas scene',
            'text': 'Transform this photo into a cozy Christmas morning. Change the person\'s clothes to a warm red and white wool sweater. Place them next to a huge lit Christmas tree with gifts. Soft fireplace glow. Maintain face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Snowy Window View',
            'platform': 'Leonardo AI',
            'description': 'Add a winter wonderland background',
            'text': 'Take the person from this photo and place them by a frosted window looking out at a heavy snowstorm. They should be holding a steaming mug of cocoa. Warm indoor lighting vs cold blue outdoor light. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'The Glamorous X-mas Party',
            'platform': 'DALL-E 3',
            'description': 'Dress up for a Christmas gala',
            'text': 'Modify this photo to show the person at a high-end Christmas party. Change their outfit to a sparkling red gown or a sharp black tuxedo. Background is a luxury hall with gold ornaments. Maintain face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Santa’s Workshop (3D)',
            'platform': 'Midjourney',
            'description': 'Turn yourself into an elf',
            'text': 'Convert the person in this photo into a 3D animated character working in Santa\'s workshop. Add an elf hat and green tunic. Whimsical and colorful toy-filled background. Maintain recognizable features.',
            'isFeatured': 'false',
          },
          {
            'title': 'Christmas Tree Decorator',
            'platform': 'Stable Diffusion XL',
            'description': 'You adding ornaments to a tree',
            'text': 'Recreate this photo showing the person hanging a golden star on a tall Christmas tree. The room should be filled with warm fairy lights. Joyful and nostalgic atmosphere. Maintain the person\'s original face.',
            'isFeatured': 'false',
          },
          {
            'title': 'The Snowy Porch',
            'platform': 'Midjourney',
            'description': 'Outdoor winter holiday look',
            'text': 'Place the person from this photo on a beautiful snowy wooden porch decorated with wreaths and red ribbons. They should be wearing a heavy winter coat and scarf. Soft falling snow. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Reindeer Magic',
            'platform': 'DALL-E 3',
            'description': 'Add a magical reindeer to your photo',
            'text': 'Modify this outdoor photo to have a realistic, magical reindeer with glowing antlers standing next to the person. Forest background with blue moonlight. Enchanting and dreamlike. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Christmas Card Family',
            'platform': 'Leonardo AI',
            'description': 'Turn family photo into a card',
            'text': 'Transform this family photo into a professional Christmas card. Add matching hats and a "Merry Christmas" banner. Warm, glowing home background with a fireplace. Maintain all family members\' faces.',
            'isFeatured': 'false',
          },
          {
            'title': 'The Nutcracker Ballet',
            'platform': 'Midjourney',
            'description': 'A theatrical artistic makeover',
            'text': 'Recreate this photo in the style of a Nutcracker theater performance. The person should be in a soldier or ballerina costume on a grand stage with toy decorations. Theatrical lighting. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Candy Cane Lane',
            'platform': 'Flux AI',
            'description': 'Bright and colorful pastel theme',
            'text': 'Transform this photo into a whimsical "Candy Cane" world. Pastel pink and red colors, giant lollipops, and sweets everywhere. The person should look like they are in a dream. Maintain face.',
            'isFeatured': 'false',
          },
        ];

      case 'Birthday':
        return [
          {
            'title': 'The Professional Shoot',
            'platform': 'Midjourney',
            'description': 'Convert your photo into a studio b-day shot',
            'text': 'Transform this casual photo into a grand birthday photoshoot. Place the person behind a beautiful 3-tier cake with lit candles. Add "Happy Birthday" balloons and confetti. Studio lighting. Maintain face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Kids Kingdom Theme',
            'platform': 'DALL-E 3',
            'description': 'Put your child in a fairy-tale party',
            'text': 'Take the child from this photo and place them in a magical birthday kingdom with a castle, floating balloons, and animated characters. The child should have a small crown. Maintain child\'s face.',
            'isFeatured': 'true',
          },
          {
            'title': 'Luxury Lounge Party',
            'platform': 'Leonardo AI',
            'description': 'A sophisticated party vibe',
            'text': 'Modify this photo to show the person at a high-end birthday lounge. Change their outfit to a stylish cocktail dress or suit. Add a champagne glass and city lights in background. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Balloon Room Explosion',
            'platform': 'Midjourney',
            'description': 'Surround yourself with 1000 balloons',
            'text': 'Take the person from this photo and place them in a room completely filled with thousands of colorful helium balloons. The person should be laughing and throwing confetti. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'First Birthday Smash',
            'platform': 'Stable Diffusion XL',
            'description': 'The classic "Cake Smash" look',
            'text': 'Recreate this baby photo as a "First Birthday Cake Smash" shoot. Add a messy cake in front of the baby and a "ONE" banner. Cute, colorful studio background. Maintain baby\'s exact face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Golden 50th Portrait',
            'platform': 'Leonardo AI',
            'description': 'A classy black & gold milestone',
            'text': 'Transform this photo into a 50th birthday celebration. Use a sophisticated black and gold theme. Add a "50 & Fabulous" sign. Elegant formal clothing and soft, flattering lighting. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Pool Party Birthday',
            'platform': 'Midjourney',
            'description': 'Add a summer party vibe',
            'text': 'Modify this photo to show the person at a luxury pool party birthday. Add sunglasses, a tropical drink, and floating balloons in the pool. Bright, sunny, and vibrant atmosphere. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Gamer Birthday Setup',
            'platform': 'DALL-E 3',
            'description': 'For the ultimate gaming fans',
            'text': 'Transform this photo into a gaming-themed birthday. Add a high-end gaming PC setup, neon RGB lights, and gaming posters in the background. The person should be wearing a headset. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Outdoor Picnic Party',
            'platform': 'Midjourney',
            'description': 'A beautiful garden celebration',
            'text': 'Take the person from this photo and place them at an aesthetic outdoor birthday picnic. Add a boho-style table, fairy lights in the trees, and a sunset background. Peaceful and trendy. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Surprise Confetti Moment',
            'platform': 'Flux AI',
            'description': 'The exact moment of surprise',
            'text': 'Modify this photo to show the person being surprised with a confetti blast. Shocked and happy expression, colorful paper flying everywhere. High-speed photography style. Maintain face.',
            'isFeatured': 'false',
          },
        ];

      case 'Independence Day':
        return [
          {
            'title': 'The Patriotic Portrait',
            'platform': 'Midjourney',
            'description': 'Add tricolor paint and spirit',
            'text': 'Transform this photo for Independence Day. Add a subtle Indian tricolor flag paint on the cheek. Place a small Indian flag in the hand. Background is the Red Fort. Maintain the face identity.',
            'isFeatured': 'true',
          },
          {
            'title': 'Historical Freedom Hero',
            'platform': 'Leonardo AI',
            'description': 'See yourself as a national hero',
            'text': 'Recreate this person as a historical Indian freedom fighter. Change clothing to traditional khadi. Use a nostalgic sepia film style. Background is a historic village. Maintain face structure.',
            'isFeatured': 'false',
          },
          {
            'title': 'Tricolor Smoke Sky',
            'platform': 'DALL-E 3',
            'description': 'Add a jet-trail sky background',
            'text': 'Place the person from this photo on a rooftop. Change the sky background to have orange, white, and green smoke trails from jets. Proud and inspired look. Maintain original face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Kite Flying Freedom',
            'platform': 'Midjourney',
            'description': 'The classic August 15th tradition',
            'text': 'Modify this photo to show the person on a terrace, flying a tricolor kite. Thousands of kites in the sky. Bright sunny day, blue sky. Joyful and traditional Indian atmosphere. Maintain face.',
            'isFeatured': 'true',
          },
          {
            'title': 'The Tricolor Saree',
            'platform': 'Stable Diffusion XL',
            'description': 'Elegant themed ethnic wear',
            'text': 'Transform the woman in this photo into an elegant Independence Day look. Change her saree to a beautiful saffron, white, and green themed silk saree. Minimalist clean background. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Monument Tribute',
            'platform': 'Leonardo AI',
            'description': 'You at the India Gate',
            'text': 'Take the person from this photo and place them in front of the India Gate in Delhi. Add a crowd with flags and a patriotic atmosphere. Sharp focus on the person. Maintain face features.',
            'isFeatured': 'false',
          },
          {
            'title': 'Patriotic Child Parade',
            'platform': 'Midjourney',
            'description': 'Kid in a school parade look',
            'text': 'Transform the child in this photo into a school Independence Day parade look. Add a white uniform, a tricolor sash, and a small flag. Proud expression, school background. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Ancient Warrior Spirit',
            'platform': 'DALL-E 3',
            'description': 'Themed as a legendary Indian warrior',
            'text': 'Recreate this person as a legendary ancient Indian warrior defending the motherland. Traditional armor, sword, and a large fluttering Indian flag in the background. Epic cinematic style. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Unity in Diversity Art',
            'platform': 'Leonardo AI',
            'description': 'Artistic symbolic transformation',
            'text': 'Convert this photo into a digital art piece. The person should be part of a collage representing Indian culture and freedom. Use tricolor brush strokes. Artistic and inspiring. Maintain face.',
            'isFeatured': 'false',
          },
          {
            'title': 'Jai Hind Desktop Style',
            'platform': 'Flux AI',
            'description': 'Clean and powerful wallpaper look',
            'text': 'Modify this photo to be a high-end patriotic wallpaper. Person standing strong, background is a stylized map of India in tricolor. High contrast, sharp details. Maintain face identity.',
            'isFeatured': 'false',
          },
        ];

      default:
        return [];
    }
  }
}