using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class MenuDeletePrefs : MonoBehaviour
{
    [MenuItem("MyTools/DeleteAllPrefs")]
    static void DeletePrefs()
    {
        PlayerPrefs.DeleteAll();
    }
}
