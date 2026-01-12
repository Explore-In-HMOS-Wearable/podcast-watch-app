import { Category } from '../model/CategoryModel';
import { common } from '@kit.AbilityKit';
import { fetch } from 'generalutils';

export async function getCategories(context: common.Context): Promise<Category[]> {
  const endpoint: string = 'endpoints/genres_podcast.json';
  return await fetch(context, endpoint) as Category[];
}
