import { Category } from '../model/category-model';
import { common } from '@kit.AbilityKit';
import { fetch } from 'generalutils';

export async function getCategories(context: common.Context): Promise<Category[]> {
  let endpoint: string = 'endpoints/genres_podcast.json';
  return await fetch(context, endpoint) as Category[];
}
