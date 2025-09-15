export class CheckEmptyUtil {
  /**
   * Check whether the object is empty.
   *
   * @param obj Objects to be checked.
   * @returns Return true if the object is empty or has no properties; Otherwise return false.
   */
  static isEmptyObj(obj: Object): boolean {
    if (obj === null || typeof obj !== 'object') {
      return true;
    }
    return Object.keys(obj).length === 0;
  }
}