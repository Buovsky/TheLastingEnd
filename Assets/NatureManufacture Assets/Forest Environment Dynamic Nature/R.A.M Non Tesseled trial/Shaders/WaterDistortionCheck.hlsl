float4 _CameraDepthTexture_TexelSize;


#if UNITY_REVERSED_Z
    // TODO: workaround. There's a bug where SHADER_API_GL_CORE gets erroneously defined on switch.
#if (defined(SHADER_API_GLCORE) && !defined(SHADER_API_SWITCH)) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
        //GL with reversed z => z clip range is [near, -far] -> should remap in theory but dont do it in practice to save some perf (range is close enough)
#define UNITY_Z_0_FAR_FROM_CLIPSPACE(coord) max(-(coord), 0)
#else
        //D3d with reversed Z => z clip range is [near, 0] -> remapping to [0, far]
        //max is required to protect ourselves from near plane not being correct/meaningfull in case of oblique matrices.
#define UNITY_Z_0_FAR_FROM_CLIPSPACE(coord) max(((1.0-(coord)/_ProjectionParams.y)*_ProjectionParams.z),0)
#endif
#elif UNITY_UV_STARTS_AT_TOP
    //D3d without reversed z => z clip range is [0, far] -> nothing to do
#define UNITY_Z_0_FAR_FROM_CLIPSPACE(coord) (coord)
#else
    //Opengl => z clip range is [-near, far] -> should remap in theory but dont do it in practice to save some perf (range is close enough)
#define UNITY_Z_0_FAR_FROM_CLIPSPACE(coord) (coord)
#endif



float2 AlignWithGrabTexel(float2 uvFixed)
{
#if UNITY_UV_STARTS_AT_TOP
		if (_CameraDepthTexture_TexelSize.y < 0) {
			uvFixed.y = 1 - uvFixed.y;
		}
#endif

    return
		(floor(uvFixed * _CameraDepthTexture_TexelSize.zw) + 0.5) *
		abs(_CameraDepthTexture_TexelSize.xy);
}

float Unity_Remap_float4(float In, float2 InMinMax, float2 OutMinMax)
{
    return OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
}

void ColorBelowWater(float4 screenPos, float2 uvOffset, out float2 uvFixed, out float depthDifference)
{
    float screenW = screenPos.w;
    
    uvOffset.y *= _CameraDepthTexture_TexelSize.z * abs(_CameraDepthTexture_TexelSize.y);
    uvFixed = AlignWithGrabTexel((screenPos.xy + uvOffset) / screenW);
	
    //float backgroundDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
    float backgroundDepth = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(uvFixed), _ZBufferParams);
    
    float surfaceDepth = UNITY_Z_0_FAR_FROM_CLIPSPACE(screenPos.z);
    
    
    depthDifference = backgroundDepth - surfaceDepth;
   
    if (depthDifference < 0)
    {
        //uvOffset *= saturate(depthDifference);
        //uvFixed = AlignWithGrabTexel((screenPos.xy + uvOffset) / screenPos.w);
        uvFixed = AlignWithGrabTexel((screenPos.xy) / screenW);
    
    }
    
    backgroundDepth = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(uvFixed), _ZBufferParams);
   
    depthDifference = backgroundDepth - surfaceDepth;
	

}

void ColorBelowWater_float(float4 screenPos, float2 uvOffset, out float2 uvFixed, out float depthDifference)
{
    ColorBelowWater(screenPos, uvOffset, uvFixed, depthDifference);
}

