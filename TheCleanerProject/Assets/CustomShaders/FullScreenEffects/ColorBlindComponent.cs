using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable, VolumeComponentMenuForRenderPipeline("Custom/ColorBlind", typeof(UniversalRenderPipeline))]
public class ColorBlindComponent : VolumeComponent, IPostProcessComponent
{
    public enum ColorBlindMode
    {
        Normal = 0,
        Protanopia = 1,
        Protanomaly = 2,
        Deuteranopia = 3,
        Deuteranomaly = 4,
        Tritanopia = 5,
        Tritanomaly = 6,
        Achromatopsia = 7,
        Achromatomaly = 8,
    }

    // For example, an intensity parameter that goes from 0 to 1
    public BoolParameter Active = new BoolParameter(true);
    public ColorBlindModeParameterType mode = new ColorBlindModeParameterType(ColorBlindMode.Normal);

    public Color[,] RGB =
    {
        { new Color(1f,0f,0f),   new Color(0f,1f,0f), new Color(0f,0f,1f) },    // Normal
        { new Color(.56667f, .43333f, 0f), new Color(.55833f, .44167f, 0f), new Color(0f, .24167f, .75833f) },    // Protanopia
        { new Color(.81667f, .18333f, 0f), new Color(.33333f, .66667f, 0f), new Color(0f, .125f, .875f)    }, // Protanomaly
        { new Color(.625f, .375f, 0f), new Color(.70f, .30f, 0f), new Color(0f, .30f, .70f)    },   // Deuteranopia
        { new Color(.80f, .20f, 0f), new Color(.25833f, .74167f, 0), new Color(0f, .14167f, .85833f)    },    // Deuteranomaly
        { new Color(.95f, .05f, 0), new Color(0f, .43333f, .56667f), new Color(0f, .475f, .525f) }, // Tritanopia
        { new Color(.96667f, .03333f, 0), new Color(0f, .73333f, .26667f), new Color(0f, .18333f, .81667f) }, // Tritanomaly
        { new Color(.299f, .587f, .114f), new Color(.299f, .587f, .114f), new Color(.299f, .587f, .114f)  },   // Achromatopsia
        { new Color(.618f, .32f, .062f), new Color(.163f, .775f, .062f), new Color(.163f, .320f, .516f)  }    // Achromatomaly
    };


    // Other 'Parameter' variables you might have

    // Tells when our effect should be rendered
    public bool IsActive() => Active.value;

    // I have no idea what this does yet but I'll update the post once I find an usage
    public bool IsTileCompatible() => true;
}

[Serializable]
public sealed class ColorBlindModeParameterType : VolumeParameter<ColorBlindComponent.ColorBlindMode> { public ColorBlindModeParameterType(ColorBlindComponent.ColorBlindMode value, bool overrideState = false) : base(value, overrideState) { } }



