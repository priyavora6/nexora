// lib/services/seed/prompts/couple_romance_prompts.dart

class CoupleRomancePrompts {
  static List<Map<String, dynamic>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Valentine Special':
        return [
          {
            'title': 'Romantic Candlelight Dinner',
            'platform': 'Midjourney',
            'description': 'Intimate dinner setting for two',
            'text': 'Cinematic shot of a romantic candlelight dinner for an Indian couple on a rooftop, soft warm lighting, rose petals on table, city skyline in background, bokeh effect, elegant evening wear, 8K --ar 16:9 --v 6.0',
          },
          {
            'title': 'Heart-shaped Balloons Surprise',
            'platform': 'DALL-E 3',
            'description': 'Surprise room decoration',
            'text': 'A room filled with red heart-shaped balloons, an Indian man surprising his partner, joyful expressions, warm cozy lighting, professional photography, romantic atmosphere.',
          },
        ];
      case 'Engagement Proposal':
        return [
          {
            'title': 'Beachside Ring Proposal',
            'platform': 'Leonardo AI',
            'description': 'Sunset proposal on beach',
            'text': 'Indian man kneeling on one knee, proposing with a diamond ring to his girlfriend on a serene beach at sunset, waves in background, golden hour lighting, emotional and high detail.',
          },
        ];
      case 'Couple Photoshoot':
        return [
          {
            'title': 'Traditional Ethnic Photoshoot',
            'platform': 'Midjourney',
            'description': 'Couple in ethnic wear',
            'text': 'Indian couple in traditional designer ethnic wear, standing in a royal palace courtyard, intricate embroidery, majestic architecture, soft sunlight, high fashion photography --ar 4:5 --v 6.0',
          },
        ];
      case 'Pre-Wedding':
        return [
          {
            'title': 'Cinematic Pre-Wedding Walk',
            'platform': 'Midjourney',
            'description': 'Couple walking in nature',
            'text': 'Beautiful Indian couple walking hand-in-hand through a lush green garden, pre-wedding photoshoot style, flowing gowns, sunlight filtering through trees, dreamy and romantic --ar 16:9 --v 6.0',
          },
        ];
      case 'Anniversary':
        return [
          {
            'title': 'Anniversary Celebration Cake',
            'platform': 'DALL-E 3',
            'description': 'Cutting anniversary cake',
            'text': 'Indian couple celebrating their 10th anniversary, cutting a beautiful tiered cake, family in background, warm lighting, festive mood, high detail.',
          },
        ];
      case 'Romantic Scenes':
        return [
          {
            'title': 'Couple in Rain',
            'platform': 'Leonardo AI',
            'description': 'Dancing in the rain',
            'text': 'Indian couple dancing joyfully in the rain under a single umbrella, street lights reflecting on wet pavement, romantic and moody, cinematic lighting.',
          },
        ];
      default:
        return [];
    }
  }
}
