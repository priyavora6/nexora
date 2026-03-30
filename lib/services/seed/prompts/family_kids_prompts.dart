// lib/services/seed/prompts/family_kids_prompts.dart

class FamilyKidsPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Family Portrait':
        return [
          {
            'title': 'Casual to Royal Family',
            'platform': 'Midjourney',
            'description': 'See your family in royal ethnic wear',
            'text': 'Transform this family photo into a royal Indian portrait. Change the clothing to coordinated premium silk ethnic wear (Sherwanis and Lehengas). Set the background to a grand heritage palace hallway with warm golden lighting. Maintain the exact faces and height differences of all family members.',
          },
          {
            'title': 'Studio Portrait Upgrade',
            'platform': 'Leonardo AI',
            'description': 'Turn a home photo into a studio shot',
            'text': 'Recreate this family group photo as a professional studio portrait. Use a clean, soft textured gray background. Improve the lighting to professional three-point studio lighting. Keep all family members in their original poses but enhance the image quality to 8k resolution.',
          },
          {
            'title': 'Festival Joy Theme',
            'platform': 'DALL-E 3',
            'description': 'Add a Diwali/Festive vibe to your photo',
            'text': 'Take the people from this photo and place them in a festive Diwali setting. Add glowing diyas, a colorful rangoli on the floor, and fairy lights in the background. Ensure the family is laughing and looking at the camera. Maintain their original facial features.',
          },
          {
            'title': 'Garden Picnic Vibe',
            'platform': 'Stable Diffusion XL',
            'description': 'Move your family to a beautiful park',
            'text': 'Transform this indoor family photo into an outdoor garden picnic. Change the background to a lush green park with a sun-dappled lawn. Add a picnic basket and flowers. Keep the family members exactly as they are but adjust the lighting to natural sunlight.',
          },
          {
            'title': 'Generations Legacy',
            'platform': 'Midjourney',
            'description': 'A timeless black and white portrait',
            'text': 'Convert this multi-generational family photo into a timeless black and white fine-art portrait. Use high-contrast lighting to emphasize textures. The style should be elegant and prestigious, suitable for a framed wall portrait. Maintain all facial identities.',
          },
          {
            'title': 'Matching Outfits Theme',
            'platform': 'Leonardo AI',
            'description': 'Give everyone matching clothes',
            'text': 'Modify this family photo so that every member is wearing matching white t-shirts and blue denim jeans. The background should be a minimalist modern living room. Maintain the original expressions and faces of every person.',
          },
          {
            'title': 'Golden Hour Outdoor',
            'platform': 'DALL-E 3',
            'description': 'Beautiful sunset lighting for family',
            'text': 'Recreate this family photo during the golden hour. The sunlight should be warm and soft, creating a glow around the family. Place them in a scenic mustard field. Keep the family members recognizable and sharp.',
          },
          {
            'title': 'The Grand Reunion',
            'platform': 'Midjourney',
            'description': 'Perfect for large joint families',
            'text': 'Take this large joint family photo and enhance it. Ensure every face is sharp and clear. Change the setting to a traditional ancestral home courtyard (Aangan). Add a warm, nostalgic film-style color grading. Maintain all individual features.',
          },
          {
            'title': 'Cozy Winter Morning',
            'platform': 'Stable Diffusion XL',
            'description': 'Add a winter/holiday feel',
            'text': 'Transform this family photo into a cozy winter scene. Change their clothes to warm sweaters and scarves. Add a fireplace in the background and soft morning mist outside the window. Maintain the family’s original smiles and features.',
          },
          {
            'title': 'Rainy Day Cuddle',
            'platform': 'Midjourney',
            'description': 'A moody monsoon family moment',
            'text': 'Modify this family photo to look like a cozy monsoon day. Add a window with rain droplets in the background and soft, moody indoor lighting. Keep the family members in a warm embrace. Maintain all facial details accurately.',
          },
        ];

      case 'Baby Newborn':
        return [
          {
            'title': 'Angel on a Cloud',
            'platform': 'Midjourney',
            'description': 'Put your baby in a dream world',
            'text': 'Take the photo of this sleeping baby and place them on a soft, fluffy white cloud in a pastel blue sky. Add a tiny pair of golden angel wings to the baby. The lighting should be ethereal and magical. Keep the baby’s face exactly as in the original.',
          },
          {
            'title': 'Flower Basket Newborn',
            'platform': 'Leonardo AI',
            'description': 'A professional newborn prop shoot',
            'text': 'Recreate this baby photo as a professional newborn shoot. Place the baby inside a rustic wicker basket filled with soft wool and surrounded by real roses. Use a shallow depth of field and soft studio lighting. Maintain the baby’s cute facial features.',
          },
          {
            'title': 'Little Krishna Theme',
            'platform': 'DALL-E 3',
            'description': 'Traditional makeover for your baby',
            'text': 'Transform this baby boy into a "Little Krishna". Add a peacock feather crown, a small flute in his hand, and traditional yellow dhoti. Place him in a traditional Vrindavan garden setting. Maintain the baby’s original face and expressions.',
          },
          {
            'title': 'Pixar Style Baby',
            'platform': 'Stable Diffusion XL',
            'description': 'Turn your baby into a 3D movie character',
            'text': 'Convert this baby into a 3D Disney-Pixar style character. Give them big, sparkly eyes and soft 3D textures. The baby should be recognizable but rendered in a high-quality animation style. Bright and colorful background.',
          },
          {
            'title': 'Baby on the Moon',
            'platform': 'Midjourney',
            'description': 'A whimsical outer space theme',
            'text': 'Take this baby and place them sleeping on a glowing crescent moon. The background should be a magical starry night sky with floating stars. Soft, dreamy lighting. Maintain the baby’s original face and sleeping pose.',
          },
          {
            'title': 'Little Princess Makeover',
            'platform': 'Leonardo AI',
            'description': 'A royal theme for baby girls',
            'text': 'Transform this baby girl into a little princess. Change her outfit to a tiny pink gown and add a small, sparkling tiara on her head. Set the background to a fairy-tale garden. Maintain the baby’s natural cute features.',
          },
          {
            'title': 'Naming Ceremony Decor',
            'platform': 'DALL-E 3',
            'description': 'Add a traditional ceremony background',
            'text': 'Place the baby from this photo in a beautiful traditional Indian naming ceremony (Namkaran) setup. Add marigold flower decorations and a traditional cradle. The baby should be in ethnic wear. Maintain the baby’s original face.',
          },
          {
            'title': 'Baby Jungle Safari',
            'platform': 'Midjourney',
            'description': 'Fun adventure theme for kids',
            'text': 'Modify this baby photo to look like a jungle safari. Place the baby wearing a small explorer hat next to a friendly, 3D animated lion and elephant. The background should be a lush green jungle. Maintain the baby’s original face.',
          },
          {
            'title': 'Newborn Macro Detail',
            'platform': 'Stable Diffusion XL',
            'description': 'Artistic focus on tiny hands/feet',
            'text': 'Create an artistic macro shot of this baby’s tiny hands or feet. Use soft, moody lighting and a blurred background. The focus should be on the delicate skin textures and tiny nails. High-end professional photography style.',
          },
          {
            'title': 'Super-Baby Transformation',
            'platform': 'Flux AI',
            'description': 'Your baby as a tiny superhero',
            'text': 'Transform this baby into a tiny superhero. Add a small red cape and a superhero suit. The baby should be "flying" over a toy city. Playful and heroic atmosphere. Maintain the baby’s recognizable face.',
          },
        ];

      case 'Kids Children':
        return [
          {
            'title': 'My Kid as an Astronaut',
            'platform': 'Midjourney',
            'description': 'A dream-job transformation',
            'text': 'Transform the child in this photo into an astronaut. Change their clothes to a realistic NASA spacesuit. Place them on the surface of the moon with planet Earth visible in the background. Maintain the child’s face and excited expression.',
          },
          {
            'title': 'Cartoon Adventure World',
            'platform': 'Leonardo AI',
            'description': 'Move your kid into their favorite cartoon',
            'text': 'Take the child from this photo and place them in a vibrant 2D animated cartoon world. The child should stay 3D but the background should be hand-drawn style with talking animals and bright colors. Maintain the child’s identity.',
          },
          {
            'title': 'The Little Chef',
            'platform': 'DALL-E 3',
            'description': 'A fun career-themed shoot',
            'text': 'Modify this photo to show the child as a professional chef. Change their clothes to a chef’s coat and a tall white hat. Place them in a professional kitchen tossing flour. Maintain the child’s face and playful spirit.',
          },
          {
            'title': 'Fantasy Fairytale Prince',
            'platform': 'Stable Diffusion XL',
            'description': 'A royal makeover for boys',
            'text': 'Transform this boy into a prince from a fantasy movie. Change his clothes to a velvet royal tunic with a sword at his waist. Set the background to a magical castle. Maintain the child’s original face and hair.',
          },
          {
            'title': 'School Topper Achievement',
            'platform': 'Midjourney',
            'description': 'Celebrate your kid’s success',
            'text': 'Recreate this photo of a child as a high-achieving student. Add a graduation cap, a trophy in their hand, and a "Top Ranker" banner in the background. The setting should be a prestigious school hall. Maintain the child’s proud face.',
          },
          {
            'title': 'Kids Superhero Duo',
            'platform': 'Leonardo AI',
            'description': 'Best for siblings/friends',
            'text': 'Transform the two children in this photo into a superhero duo. Give them matching custom superhero suits and capes. Add energy effects to their hands. The background should be a city skyline at night. Maintain both faces.',
          },
          {
            'title': 'The Forest Explorer',
            'platform': 'DALL-E 3',
            'description': 'Add an adventure vibe',
            'text': 'Modify this photo to show the child as a brave forest explorer. Add a backpack, a magnifying glass, and friendly butterflies around them. The background should be an enchanted forest with giant flowers. Maintain the face.',
          },
          {
            'title': 'Little Dancer Stage',
            'platform': 'Midjourney',
            'description': 'A professional performance look',
            'text': 'Take the child from this photo and place them on a grand stage under a spotlight. Change their outfit to a beautiful dance costume (Kathak/Ballet). Add a cheering crowd in the blur. Maintain the child’s focused expression.',
          },
          {
            'title': 'Child with Mythical Pet',
            'platform': 'Stable Diffusion XL',
            'description': 'Add a dragon/unicorn to the photo',
            'text': 'Recreate this photo of a child sitting on the grass, but add a small, friendly baby dragon sitting next to them. The dragon should look realistic. The child should be looking at the dragon. Maintain the child’s face perfectly.',
          },
          {
            'title': 'Sports Champion Star',
            'platform': 'Flux AI',
            'description': 'Your kid as a sports hero',
            'text': 'Transform this child into a famous sports star. Change their clothes to a cricket or football jersey with their name on it. Set the background to a crowded stadium. Maintain the child’s energetic face.',
          },
        ];

      case 'Maternity Pregnancy':
        return [
          {
            'title': 'Floral Goddess Maternity',
            'platform': 'Midjourney',
            'description': 'A high-end maternity fashion look',
            'text': 'Transform this maternity photo of an Indian woman into a "Floral Goddess" theme. Change her dress to a flowing, ethereal white gown. Surround her with a massive arrangement of pink and white flowers. Maintain the face and the baby bump shape.',
          },
          {
            'title': 'Traditional Godh Bharai',
            'platform': 'Leonardo AI',
            'description': 'Celebrate your baby shower rituals',
            'text': 'Take the pregnant woman from this photo and place her in a traditional Indian Godh Bharai (baby shower) ceremony. Change her outfit to a rich silk saree. Add flower garlands and family members blessing her. Maintain her original face.',
          },
          {
            'title': 'Maternity Silhouette Sunset',
            'platform': 'DALL-E 3',
            'description': 'A beautiful artistic silhouette',
            'text': 'Recreate this maternity photo as a stunning silhouette at the beach during sunset. The orange sun should be directly behind the woman, highlighting the beautiful curve of the baby bump. Artistic and peaceful. Maintain her profile shape.',
          },
          {
            'title': 'Waiting for You Dream',
            'platform': 'Stable Diffusion XL',
            'description': 'A soft, emotional maternity scene',
            'text': 'Transform this photo into a soft, dreamy nursery setting. The woman should be sitting in a rocking chair, looking lovingly at her bump. Soft window light and pastel tones. Maintain the woman’s facial features and peaceful expression.',
          },
          {
            'title': 'Nature Mother Earth',
            'platform': 'Midjourney',
            'description': 'A majestic nature-themed shoot',
            'text': 'Transform this pregnant woman into "Mother Earth". Change her clothing to a dress made of green leaves and vines. Set the background to a majestic forest waterfall. Use epic, cinematic lighting. Maintain the facial features.',
          },
          {
            'title': 'Modern Minimalist Maternity',
            'platform': 'Leonardo AI',
            'description': 'Clean, black and white style',
            'text': 'Convert this maternity photo into a high-fashion, minimalist black and white portrait. Use a plain black background and sharp side lighting to emphasize the baby bump. Maintain the woman’s face and identity.',
          },
          {
            'title': 'Underwater Maternity Magic',
            'platform': 'DALL-E 3',
            'description': 'A surreal and unique transformation',
            'text': 'Take the woman from this photo and place her in a surreal underwater setting with flowing fabrics. Sunlight should ripple through the water. The image should feel weightless and magical. Maintain her face and pregnancy bump.',
          },
          {
            'title': 'Maternity with Future Sibling',
            'platform': 'Midjourney',
            'description': 'Involve your first child',
            'text': 'Modify this photo so the woman’s older child is kissing her baby bump. Add a warm, glowing atmosphere. The setting should be a cozy home garden. Maintain the faces of both the mother and the child.',
          },
          {
            'title': 'Royal Queen Maternity',
            'platform': 'Stable Diffusion XL',
            'description': 'A regal and powerful look',
            'text': 'Transform this maternity photo into a royal queen theme. Change her dress to a heavy royal lehenga and add a crown. Set the background to a throne room. The woman should look powerful and graceful. Maintain the face.',
          },
          {
            'title': 'Spring Bloom Maternity',
            'platform': 'Flux AI',
            'description': 'Fresh and colorful spring vibe',
            'text': 'Place the pregnant woman from this photo in a vast field of blooming sunflowers. Use bright, cheerful morning lighting. She should be wearing a light, breezy sundress. Maintain her original facial features.',
          },
        ];

      case 'Grandparents':
        return [
          {
            'title': 'Grandparents as Royals',
            'platform': 'Midjourney',
            'description': 'A regal tribute to your elders',
            'text': 'Transform the elderly couple in this photo into a King and Queen. Change their clothes to royal velvet ethnic wear with heavy gold embroidery. The background should be a royal durbari hall. Maintain their wise and kind faces exactly.',
          },
          {
            'title': 'Old Photo Restored',
            'platform': 'Leonardo AI',
            'description': 'Fix your grandparents old blurry photos',
            'text': 'Take this old, blurry photo of grandparents and restore it. Enhance the facial details to be sharp and clear. Add realistic color to the black and white image. Improve the overall quality to 4k while keeping the nostalgic feel.',
          },
          {
            'title': 'Grandma Storyteller',
            'platform': 'DALL-E 3',
            'description': 'A magical scene with grandkids',
            'text': 'A warm loving Indian grandmother sitting with young grandchildren in a cozy home, telling magical bedtime stories from an ancient glowing book, fairy tale characters and sparkles coming to life floating in the air around them, warm golden lighting, heartwarming scene, Pixar animation style, highly detailed, 8k quality',
          },
          {
            'title': 'The Patriarch Portrait',
            'platform': 'Stable Diffusion XL',
            'description': 'A dignified leader look for Grandpa',
            'text': 'Transform this photo of a grandfather into a dignified patriarch portrait. Change his background to a classic wood-paneled library. Use dramatic, respectful lighting. Maintain his original facial features and beard/hair.',
          },
          {
            'title': 'Grandparents Golden Anniversary',
            'platform': 'Midjourney',
            'description': 'Celebrate 50 years of love',
            'text': 'Recreate this photo of grandparents in a 50th-anniversary theme. Add golden decorations, a cake, and a "50 Years of Love" banner. They should be holding hands. Use warm, celebratory lighting. Maintain their faces.',
          },
          {
            'title': 'Grandparents Village Heritage',
            'platform': 'Leonardo AI',
            'description': 'A nostalgic rural India theme',
            'text': 'Place the grandparents from this photo in a nostalgic rural Indian village setting. Add a charpai (cot), a banyan tree, and an old village house. The lighting should feel like a peaceful evening. Maintain their features.',
          },
          {
            'title': 'Young Versions of Them',
            'platform': 'DALL-E 3',
            'description': 'See your grandparents in their 20s',
            'text': 'Recreate the people in this photo as they would have looked in their 20s. Maintain their bone structure and key features so they are recognizable, but remove wrinkles and change hair color. Style them in 1960s Indian fashion.',
          },
          {
            'title': 'Grandpa with Superbike',
            'platform': 'Midjourney',
            'description': 'A cool and modern transformation',
            'text': 'Transform this grandfather into a "Cool Grandpa". Change his clothes to a stylish leather jacket and sunglasses. Place him leaning against a modern high-end motorcycle. Maintain his recognizable facial features.',
          },
          {
            'title': 'Grandma’s Kitchen Magic',
            'platform': 'Stable Diffusion XL',
            'description': 'A warm, traditional cooking scene',
            'text': 'Modify this photo of a grandmother to show her in a traditional rustic kitchen. She should be making rotis on a chulha (clay stove). Add a warm, inviting glow. The image should feel like a sweet childhood memory. Maintain her face.',
          },
          {
            'title': 'Elders Garden Peace',
            'platform': 'Flux AI',
            'description': 'A serene and calm lifestyle shoot',
            'text': 'Transform this photo of grandparents into a serene garden scene. They should be sitting on a bench, surrounded by blooming flowers, looking peaceful. Use soft morning light. Maintain their original facial expressions.',
          },
        ];

      case 'Siblings':
        return [
          {
            'title': 'Superhero Sibling Duo',
            'platform': 'Midjourney',
            'description': 'Turn brothers/sisters into heroes',
            'text': 'Transform the two siblings in this photo into a legendary superhero duo. Give them custom suits with their initials as logos. One should have fire powers and the other ice powers. Use cinematic action-movie lighting. Maintain both faces.',
          },
          {
            'title': 'Rakhi Bond Special',
            'platform': 'Leonardo AI',
            'description': 'A perfect Raksha Bandhan memory',
            'text': 'Take this brother and sister photo and set it in a traditional Raksha Bandhan theme. Change their clothes to festive ethnic wear. Add a thali with a rakhi and sweets. The background should be a decorated Indian home. Maintain the faces.',
          },
          {
            'title': 'Siblings in Anime World',
            'platform': 'DALL-E 3',
            'description': 'Turn your kids into anime characters',
            'text': 'Convert the siblings in this photo into characters from a high-quality anime (Ghibli style). They should be recognizable but drawn in anime style. The background should be a magical landscape with floating islands.',
          },
          {
            'title': 'Partners in Crime (Meme)',
            'platform': 'Stable Diffusion XL',
            'description': 'A funny and playful transformation',
            'text': 'Modify this sibling photo to look like a funny "wanted" poster from the wild west. Add text "Wanted for Stealing Cookies". Use a sepia vintage paper effect. Maintain their mischievous facial expressions and faces.',
          },
          {
            'title': 'Siblings 3D Cartoon',
            'platform': 'Midjourney',
            'description': 'Turn them into 3D movie stars',
            'text': 'Recreate these siblings as 3D characters in a movie like "Toy Story" or "The Incredibles". Give them exaggerated but cute features. The background should be a colorful playroom. Maintain their recognizable identities.',
          },
          {
            'title': 'Future Professional Duo',
            'platform': 'Leonardo AI',
            'description': 'See them as successful adults',
            'text': 'Transform these two kids into their future adult selves. One as a scientist and the other as an artist. Place them in a shared professional studio. They should look like grown-up versions of themselves. Maintain the facial structure.',
          },
          {
            'title': 'Siblings Royal Heirs',
            'platform': 'DALL-E 3',
            'description': 'A regal prince and princess look',
            'text': 'Take the siblings from this photo and transform them into a royal prince and princess. Change their clothes to heavy royal robes and add crowns. Set the background to a castle balcony. Maintain both of their faces.',
          },
          {
            'title': 'Matching School Day Memory',
            'platform': 'Midjourney',
            'description': 'A nostalgic school-themed shoot',
            'text': 'Modify this sibling photo to show them in matching old-fashioned school uniforms with backpacks. Set the background to a nostalgic school hallway. Use a warm, film-like filter. Maintain their original height and facial features.',
          },
          {
            'title': 'Siblings Space Explorers',
            'platform': 'Stable Diffusion XL',
            'description': 'An outer space adventure duo',
            'text': 'Transform these siblings into space explorers. Change their clothes to sleek sci-fi jumpsuits. They should be standing on a spaceship looking out at a nebula. Use vibrant neon lighting. Maintain their recognizable faces.',
          },
          {
            'title': 'Rainy Day Childhood',
            'platform': 'Flux AI',
            'description': 'A sweet and natural outdoor scene',
            'text': 'Modify this sibling photo to show them playing in the rain with paper boats. They should be wearing colorful raincoats and boots. Add splashing water and a joyful atmosphere. Maintain their original facial features.',
          },
        ];

      default:
        return [];
    }
  }
}
