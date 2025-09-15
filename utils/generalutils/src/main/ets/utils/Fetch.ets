import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

export async function fetch(context: Context, endpoint: string) {

  let items = new Object();

  try {
    await context.resourceManager.getRawFileContent(endpoint)
      .then((value: Uint8Array) => {
        let rawFile = value;
        const decoder = new util.TextDecoder();
        const jsonString = decoder.decodeToString(value);
        items = JSON.parse(jsonString);
      })
      .catch((error: BusinessError) => {
        console.error("getRawFileContent promise error is " + error);
      });
  } catch (error) {
    let code = (error as BusinessError).code;
    let message = (error as BusinessError).message;
    console.error(`promise getRawFileContent failed, error code: ${code}, message: ${message}.`);
  }
  return items;
}