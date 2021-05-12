Shader "NatureManufacture/URP/Layered/Full Triplanar Cover"
    {
        Properties
        {
            _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
            _BaseColor("Base Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_BaseColorMap("Base Map(RGB) Alpha(A)", 2D) = "white" {}
            _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
            _BaseTriplanarThreshold("Base Triplanar Threshold", Range(1, 8)) = 5
            [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "bump" {}
            _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_BaseMaskMap("Base Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
            _BaseMetallic("Base Metallic", Range(0, 1)) = 1
            _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
            _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
            _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
            _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
            [NoScaleOffset]_LayerMask("Layer Mask (R)", 2D) = "black" {}
            [ToggleUI]_Invert_Layer_Mask("Invert Layer Mask", Float) = 0
            _Height_Transition("Height Blend Transition", Range(0.001, 1)) = 1
            _HeightMin("Height Min", Float) = 0
            _HeightMax("Height Max", Float) = 1
            _HeightOffset("Height Offset", Float) = 0
            _HeightMin2("Height 2 Min", Float) = 0
            _HeightMax2("Height 2 Max", Float) = 1
            _HeightOffset2("Height 2 Offset", Float) = 0
            _Base2Color("Base 2 Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_Base2ColorMap("Base 2 Map", 2D) = "white" {}
            _Base2TilingOffset("Base 2 Tiling and Offset", Vector) = (1, 1, 0, 0)
            _Base2TriplanarThreshold("Base 2 Triplanar Threshold", Range(1, 8)) = 5
            [NoScaleOffset]_Base2NormalMap("Base 2 Normal Map", 2D) = "bump" {}
            _Base2NormalScale("Base 2 Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_Base2MaskMap("Base 2 Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
            _Base2Metallic("Base 2 Metallic", Range(0, 1)) = 1
            _Base2SmoothnessRemapMin("Base 2 Smoothness Remap Min", Range(0, 1)) = 0
            _Base2SmoothnessRemapMax("Base 2 Smoothness Remap Max", Range(0, 1)) = 1
            _Base2AORemapMin("Base 2 AO Remap Min", Range(0, 1)) = 0
            _Base2AORemapMax("Base 2 AO Remap Max", Range(0, 1)) = 1
            _WetColor("Wet Color Vertex(R)", Color) = (0.7735849, 0.7735849, 0.7735849, 0)
            _WetSmoothness("Wet Smoothness Vertex(R)", Range(0, 1)) = 1
            [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
            [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
            [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Opaque"
                "UniversalMaterialType" = "Lit"
                "Queue"="AlphaTest"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                };
                
                void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.WorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.WorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.WorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2);
                    float3 _Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float3 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2;
                    Unity_Multiply_float(_Split_6299d4ddcc4c74828aea40a46fdb896e_B_3, -1, _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2);
                    float2 _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0 = float2(_Multiply_de711f4a4614bd89a463b53374cf4036_Out_2, 1);
                    float2 _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float2 _Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0 = float2(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4, _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5);
                    float2 _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2;
                    Unity_Multiply_float(_Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0, _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2);
                    float2 _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_b227c84042055e8faa1a9fdc69529707_Out_2;
                    Unity_Add_float2(_Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2, _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0, _Add_b227c84042055e8faa1a9fdc69529707_Out_2);
                    float _Split_2cfb9eacd8762483941459cdf28bda97_R_1 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[0];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_G_2 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[1];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_B_3 = 0;
                    float _Split_2cfb9eacd8762483941459cdf28bda97_A_4 = 0;
                    float _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0 = float3(_Split_2cfb9eacd8762483941459cdf28bda97_R_1, _Split_2cfb9eacd8762483941459cdf28bda97_G_2, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_R_1, 1);
                    float2 _Multiply_862402885a49f18cb87278ab53bc6744_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float _Multiply_4649b768be76d784a3284bacde795359_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Multiply_4649b768be76d784a3284bacde795359_Out_2);
                    float2 _Vector2_819fcd5eb484438eacad1987576d7d67_Out_0 = float2(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4, _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5);
                    float2 _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2;
                    Unity_Multiply_float(_Vector2_819fcd5eb484438eacad1987576d7d67_Out_0, _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2);
                    float2 _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2;
                    Unity_Add_float2(_Multiply_58530ebb3c6d798b93686a76247bf505_Out_2, _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0, _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2);
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[0];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[1];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_B_3 = 0;
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_A_4 = 0;
                    float3 _Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0 = float3(_Multiply_4649b768be76d784a3284bacde795359_Out_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1);
                    float3 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float3 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float3(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float3 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float3(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float3 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float3(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    float3x3 Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1 = TransformWorldToTangent(_Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2.xyz, Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World);
                    float3 _Normalize_15ef346824db0a8797631ed8b998e673_Out_1;
                    Unity_Normalize_float3(_Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1, _Normalize_15ef346824db0a8797631ed8b998e673_Out_1);
                    XYZ_1 = (float4(_Normalize_15ef346824db0a8797631ed8b998e673_Out_1, 1.0));
                    XZ_2 = (float4(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, 1.0));
                    YZ_3 = (float4(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, 1.0));
                    XY_4 = (float4(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4);
                    float _Property_7edd97bda70eb38a8c4253094700be37_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1.xyz), _Property_7edd97bda70eb38a8c4253094700be37_Out_0, _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4);
                    float _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1.xyz), _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_a6bf16c3496e828984e7277239132d42;
                    float3 _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_a6bf16c3496e828984e7277239132d42, _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1);
                    float _Property_57dab79b7e7fc28c99642ba557430a27_Out_0 = _BaseMetallic;
                    float _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2;
                    Unity_Multiply_float(_Split_866a663ed067f988862843fe32765ff8_R_1, _Property_57dab79b7e7fc28c99642ba557430a27_Out_0, _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2);
                    float _Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0 = _BaseAORemapMin;
                    float _Property_5a040fb62cd8888895d4f920c4036587_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0 = float2(_Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0, _Property_5a040fb62cd8888895d4f920c4036587_Out_0);
                    float _Remap_de2674403349aa85b1136d42692d26f9_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_G_2, float2 (0, 1), _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0, _Remap_de2674403349aa85b1136d42692d26f9_Out_3);
                    float _Property_a1b1d767544de781a39d6415872f7285_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0 = float2(_Property_a1b1d767544de781a39d6415872f7285_Out_0, _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0);
                    float _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_A_4, float2 (0, 1), _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float3 _Vector3_4c4100faab122d8da757a32364182844_Out_0 = float3(_Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2, _Remap_de2674403349aa85b1136d42692d26f9_Out_3, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float _Property_7cdf7bda907cf087942cd072e635a869_Out_0 = _Base2Metallic;
                    float _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2;
                    Unity_Multiply_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1, _Property_7cdf7bda907cf087942cd072e635a869_Out_0, _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2);
                    float _Property_b334f6ce40e54186b9864b004fbe88d2_Out_0 = _Base2AORemapMin;
                    float _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0 = float2(_Property_b334f6ce40e54186b9864b004fbe88d2_Out_0, _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0);
                    float _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2, float2 (0, 1), _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3);
                    float _Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0 = float2(_Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0, _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0);
                    float _Remap_697b96439d3a0983800a051b2b4edd90_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4, float2 (0, 1), _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    float3 _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0 = float3(_Multiply_befa03f2838946858f28ac63a284b0f8_Out_2, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_05358f196f0ec3849124c9bfd64e3003;
                    float3 _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_4c4100faab122d8da757a32364182844_Out_0, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_05358f196f0ec3849124c9bfd64e3003, _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1);
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[0];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[1];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_B_3 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[2];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_A_4 = 0;
                    float _Property_e82022180c38e18e958213dc27e38977_Out_0 = _WetSmoothness;
                    float _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    Unity_Lerp_float(_Split_22fc6cf606e48f8fa771c4e8cab49553_B_3, _Property_e82022180c38e18e958213dc27e38977_Out_0, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1, _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.NormalTS = _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1;
                    surface.Smoothness = _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    surface.Occlusion = _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.WorldSpacePosition =          input.positionWS;
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "GBuffer"
                Tags
                {
                    "LightMode" = "UniversalGBuffer"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma multi_compile _ _GBUFFER_NORMALS_OCT
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_GBUFFER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                };
                
                void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.WorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.WorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.WorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2);
                    float3 _Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float3 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2;
                    Unity_Multiply_float(_Split_6299d4ddcc4c74828aea40a46fdb896e_B_3, -1, _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2);
                    float2 _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0 = float2(_Multiply_de711f4a4614bd89a463b53374cf4036_Out_2, 1);
                    float2 _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float2 _Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0 = float2(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4, _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5);
                    float2 _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2;
                    Unity_Multiply_float(_Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0, _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2);
                    float2 _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_b227c84042055e8faa1a9fdc69529707_Out_2;
                    Unity_Add_float2(_Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2, _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0, _Add_b227c84042055e8faa1a9fdc69529707_Out_2);
                    float _Split_2cfb9eacd8762483941459cdf28bda97_R_1 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[0];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_G_2 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[1];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_B_3 = 0;
                    float _Split_2cfb9eacd8762483941459cdf28bda97_A_4 = 0;
                    float _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0 = float3(_Split_2cfb9eacd8762483941459cdf28bda97_R_1, _Split_2cfb9eacd8762483941459cdf28bda97_G_2, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_R_1, 1);
                    float2 _Multiply_862402885a49f18cb87278ab53bc6744_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float _Multiply_4649b768be76d784a3284bacde795359_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Multiply_4649b768be76d784a3284bacde795359_Out_2);
                    float2 _Vector2_819fcd5eb484438eacad1987576d7d67_Out_0 = float2(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4, _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5);
                    float2 _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2;
                    Unity_Multiply_float(_Vector2_819fcd5eb484438eacad1987576d7d67_Out_0, _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2);
                    float2 _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2;
                    Unity_Add_float2(_Multiply_58530ebb3c6d798b93686a76247bf505_Out_2, _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0, _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2);
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[0];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[1];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_B_3 = 0;
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_A_4 = 0;
                    float3 _Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0 = float3(_Multiply_4649b768be76d784a3284bacde795359_Out_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1);
                    float3 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float3 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float3(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float3 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float3(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float3 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float3(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    float3x3 Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1 = TransformWorldToTangent(_Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2.xyz, Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World);
                    float3 _Normalize_15ef346824db0a8797631ed8b998e673_Out_1;
                    Unity_Normalize_float3(_Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1, _Normalize_15ef346824db0a8797631ed8b998e673_Out_1);
                    XYZ_1 = (float4(_Normalize_15ef346824db0a8797631ed8b998e673_Out_1, 1.0));
                    XZ_2 = (float4(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, 1.0));
                    YZ_3 = (float4(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, 1.0));
                    XY_4 = (float4(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4);
                    float _Property_7edd97bda70eb38a8c4253094700be37_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1.xyz), _Property_7edd97bda70eb38a8c4253094700be37_Out_0, _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4);
                    float _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1.xyz), _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_a6bf16c3496e828984e7277239132d42;
                    float3 _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_a6bf16c3496e828984e7277239132d42, _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1);
                    float _Property_57dab79b7e7fc28c99642ba557430a27_Out_0 = _BaseMetallic;
                    float _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2;
                    Unity_Multiply_float(_Split_866a663ed067f988862843fe32765ff8_R_1, _Property_57dab79b7e7fc28c99642ba557430a27_Out_0, _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2);
                    float _Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0 = _BaseAORemapMin;
                    float _Property_5a040fb62cd8888895d4f920c4036587_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0 = float2(_Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0, _Property_5a040fb62cd8888895d4f920c4036587_Out_0);
                    float _Remap_de2674403349aa85b1136d42692d26f9_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_G_2, float2 (0, 1), _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0, _Remap_de2674403349aa85b1136d42692d26f9_Out_3);
                    float _Property_a1b1d767544de781a39d6415872f7285_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0 = float2(_Property_a1b1d767544de781a39d6415872f7285_Out_0, _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0);
                    float _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_A_4, float2 (0, 1), _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float3 _Vector3_4c4100faab122d8da757a32364182844_Out_0 = float3(_Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2, _Remap_de2674403349aa85b1136d42692d26f9_Out_3, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float _Property_7cdf7bda907cf087942cd072e635a869_Out_0 = _Base2Metallic;
                    float _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2;
                    Unity_Multiply_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1, _Property_7cdf7bda907cf087942cd072e635a869_Out_0, _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2);
                    float _Property_b334f6ce40e54186b9864b004fbe88d2_Out_0 = _Base2AORemapMin;
                    float _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0 = float2(_Property_b334f6ce40e54186b9864b004fbe88d2_Out_0, _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0);
                    float _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2, float2 (0, 1), _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3);
                    float _Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0 = float2(_Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0, _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0);
                    float _Remap_697b96439d3a0983800a051b2b4edd90_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4, float2 (0, 1), _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    float3 _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0 = float3(_Multiply_befa03f2838946858f28ac63a284b0f8_Out_2, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_05358f196f0ec3849124c9bfd64e3003;
                    float3 _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_4c4100faab122d8da757a32364182844_Out_0, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_05358f196f0ec3849124c9bfd64e3003, _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1);
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[0];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[1];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_B_3 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[2];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_A_4 = 0;
                    float _Property_e82022180c38e18e958213dc27e38977_Out_0 = _WetSmoothness;
                    float _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    Unity_Lerp_float(_Split_22fc6cf606e48f8fa771c4e8cab49553_B_3, _Property_e82022180c38e18e958213dc27e38977_Out_0, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1, _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.NormalTS = _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1;
                    surface.Smoothness = _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    surface.Occlusion = _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.WorldSpacePosition =          input.positionWS;
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthNormals"
                Tags
                {
                    "LightMode" = "DepthNormals"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                };
                
                void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.WorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.WorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.WorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2);
                    float3 _Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float3 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2;
                    Unity_Multiply_float(_Split_6299d4ddcc4c74828aea40a46fdb896e_B_3, -1, _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2);
                    float2 _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0 = float2(_Multiply_de711f4a4614bd89a463b53374cf4036_Out_2, 1);
                    float2 _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float2 _Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0 = float2(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4, _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5);
                    float2 _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2;
                    Unity_Multiply_float(_Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0, _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2);
                    float2 _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_b227c84042055e8faa1a9fdc69529707_Out_2;
                    Unity_Add_float2(_Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2, _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0, _Add_b227c84042055e8faa1a9fdc69529707_Out_2);
                    float _Split_2cfb9eacd8762483941459cdf28bda97_R_1 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[0];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_G_2 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[1];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_B_3 = 0;
                    float _Split_2cfb9eacd8762483941459cdf28bda97_A_4 = 0;
                    float _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0 = float3(_Split_2cfb9eacd8762483941459cdf28bda97_R_1, _Split_2cfb9eacd8762483941459cdf28bda97_G_2, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_R_1, 1);
                    float2 _Multiply_862402885a49f18cb87278ab53bc6744_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float _Multiply_4649b768be76d784a3284bacde795359_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Multiply_4649b768be76d784a3284bacde795359_Out_2);
                    float2 _Vector2_819fcd5eb484438eacad1987576d7d67_Out_0 = float2(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4, _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5);
                    float2 _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2;
                    Unity_Multiply_float(_Vector2_819fcd5eb484438eacad1987576d7d67_Out_0, _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2);
                    float2 _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2;
                    Unity_Add_float2(_Multiply_58530ebb3c6d798b93686a76247bf505_Out_2, _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0, _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2);
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[0];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[1];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_B_3 = 0;
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_A_4 = 0;
                    float3 _Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0 = float3(_Multiply_4649b768be76d784a3284bacde795359_Out_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1);
                    float3 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float3 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float3(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float3 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float3(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float3 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float3(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    float3x3 Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1 = TransformWorldToTangent(_Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2.xyz, Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World);
                    float3 _Normalize_15ef346824db0a8797631ed8b998e673_Out_1;
                    Unity_Normalize_float3(_Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1, _Normalize_15ef346824db0a8797631ed8b998e673_Out_1);
                    XYZ_1 = (float4(_Normalize_15ef346824db0a8797631ed8b998e673_Out_1, 1.0));
                    XZ_2 = (float4(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, 1.0));
                    YZ_3 = (float4(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, 1.0));
                    XY_4 = (float4(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 NormalTS;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4);
                    float _Property_7edd97bda70eb38a8c4253094700be37_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1.xyz), _Property_7edd97bda70eb38a8c4253094700be37_Out_0, _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4);
                    float _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1.xyz), _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_a6bf16c3496e828984e7277239132d42;
                    float3 _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_a6bf16c3496e828984e7277239132d42, _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.NormalTS = _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.WorldSpacePosition =          input.positionWS;
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_TEXCOORD2
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 uv2 : TEXCOORD2;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.texCoord0 = input.interp2.xyzw;
                    output.color = input.interp3.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.texCoord0 = input.interp2.xyzw;
                    output.color = input.interp3.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Opaque"
                "UniversalMaterialType" = "Lit"
                "Queue"="AlphaTest"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                };
                
                void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.WorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.WorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.WorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2);
                    float3 _Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float3 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2;
                    Unity_Multiply_float(_Split_6299d4ddcc4c74828aea40a46fdb896e_B_3, -1, _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2);
                    float2 _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0 = float2(_Multiply_de711f4a4614bd89a463b53374cf4036_Out_2, 1);
                    float2 _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float2 _Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0 = float2(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4, _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5);
                    float2 _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2;
                    Unity_Multiply_float(_Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0, _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2);
                    float2 _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_b227c84042055e8faa1a9fdc69529707_Out_2;
                    Unity_Add_float2(_Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2, _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0, _Add_b227c84042055e8faa1a9fdc69529707_Out_2);
                    float _Split_2cfb9eacd8762483941459cdf28bda97_R_1 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[0];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_G_2 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[1];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_B_3 = 0;
                    float _Split_2cfb9eacd8762483941459cdf28bda97_A_4 = 0;
                    float _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0 = float3(_Split_2cfb9eacd8762483941459cdf28bda97_R_1, _Split_2cfb9eacd8762483941459cdf28bda97_G_2, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_R_1, 1);
                    float2 _Multiply_862402885a49f18cb87278ab53bc6744_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float _Multiply_4649b768be76d784a3284bacde795359_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Multiply_4649b768be76d784a3284bacde795359_Out_2);
                    float2 _Vector2_819fcd5eb484438eacad1987576d7d67_Out_0 = float2(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4, _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5);
                    float2 _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2;
                    Unity_Multiply_float(_Vector2_819fcd5eb484438eacad1987576d7d67_Out_0, _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2);
                    float2 _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2;
                    Unity_Add_float2(_Multiply_58530ebb3c6d798b93686a76247bf505_Out_2, _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0, _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2);
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[0];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[1];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_B_3 = 0;
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_A_4 = 0;
                    float3 _Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0 = float3(_Multiply_4649b768be76d784a3284bacde795359_Out_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1);
                    float3 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float3 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float3(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float3 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float3(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float3 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float3(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    float3x3 Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1 = TransformWorldToTangent(_Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2.xyz, Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World);
                    float3 _Normalize_15ef346824db0a8797631ed8b998e673_Out_1;
                    Unity_Normalize_float3(_Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1, _Normalize_15ef346824db0a8797631ed8b998e673_Out_1);
                    XYZ_1 = (float4(_Normalize_15ef346824db0a8797631ed8b998e673_Out_1, 1.0));
                    XZ_2 = (float4(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, 1.0));
                    YZ_3 = (float4(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, 1.0));
                    XY_4 = (float4(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4);
                    float _Property_7edd97bda70eb38a8c4253094700be37_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1.xyz), _Property_7edd97bda70eb38a8c4253094700be37_Out_0, _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2);
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4);
                    float _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1.xyz), _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_a6bf16c3496e828984e7277239132d42;
                    float3 _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_a6bf16c3496e828984e7277239132d42, _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1);
                    float _Property_57dab79b7e7fc28c99642ba557430a27_Out_0 = _BaseMetallic;
                    float _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2;
                    Unity_Multiply_float(_Split_866a663ed067f988862843fe32765ff8_R_1, _Property_57dab79b7e7fc28c99642ba557430a27_Out_0, _Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2);
                    float _Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0 = _BaseAORemapMin;
                    float _Property_5a040fb62cd8888895d4f920c4036587_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0 = float2(_Property_27a0c97d2207ca89af0ef30bd5d6c062_Out_0, _Property_5a040fb62cd8888895d4f920c4036587_Out_0);
                    float _Remap_de2674403349aa85b1136d42692d26f9_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_G_2, float2 (0, 1), _Vector2_6f9956f2c0302f8382a2f5c741da0609_Out_0, _Remap_de2674403349aa85b1136d42692d26f9_Out_3);
                    float _Property_a1b1d767544de781a39d6415872f7285_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0 = float2(_Property_a1b1d767544de781a39d6415872f7285_Out_0, _Property_a0fd73b9dac07285b1d70b54ca659a15_Out_0);
                    float _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_A_4, float2 (0, 1), _Vector2_fc66e35bdc72f589a802edd7bfb7555b_Out_0, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float3 _Vector3_4c4100faab122d8da757a32364182844_Out_0 = float3(_Multiply_aa5299d5bb4d2080af3ab6b593e1aa2c_Out_2, _Remap_de2674403349aa85b1136d42692d26f9_Out_3, _Remap_0c05c4433df8c8898decaf8c2ca17cb2_Out_3);
                    float _Property_7cdf7bda907cf087942cd072e635a869_Out_0 = _Base2Metallic;
                    float _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2;
                    Unity_Multiply_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1, _Property_7cdf7bda907cf087942cd072e635a869_Out_0, _Multiply_befa03f2838946858f28ac63a284b0f8_Out_2);
                    float _Property_b334f6ce40e54186b9864b004fbe88d2_Out_0 = _Base2AORemapMin;
                    float _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0 = float2(_Property_b334f6ce40e54186b9864b004fbe88d2_Out_0, _Property_0ee0b6f693d6ed8c830707e558e38b7b_Out_0);
                    float _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2, float2 (0, 1), _Vector2_ec982e7ec425d587a82289de9dcba701_Out_0, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3);
                    float _Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0 = float2(_Property_a9807e270c8ae68db2a00b23b4aceb82_Out_0, _Property_0106a1baaa017b8d93c6d416dda17e61_Out_0);
                    float _Remap_697b96439d3a0983800a051b2b4edd90_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4, float2 (0, 1), _Vector2_92da7adc0ff49f8cba8bafca74304dbd_Out_0, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    float3 _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0 = float3(_Multiply_befa03f2838946858f28ac63a284b0f8_Out_2, _Remap_e36fdc5121ad638e8112d325bff9b6c2_Out_3, _Remap_697b96439d3a0983800a051b2b4edd90_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_05358f196f0ec3849124c9bfd64e3003;
                    float3 _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_4c4100faab122d8da757a32364182844_Out_0, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _Vector3_d5775a771fd8c48e8c9af11a4af046aa_Out_0, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_05358f196f0ec3849124c9bfd64e3003, _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1);
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[0];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[1];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_B_3 = _HeightBlend_05358f196f0ec3849124c9bfd64e3003_OutVector4_1[2];
                    float _Split_22fc6cf606e48f8fa771c4e8cab49553_A_4 = 0;
                    float _Property_e82022180c38e18e958213dc27e38977_Out_0 = _WetSmoothness;
                    float _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    Unity_Lerp_float(_Split_22fc6cf606e48f8fa771c4e8cab49553_B_3, _Property_e82022180c38e18e958213dc27e38977_Out_0, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1, _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.NormalTS = _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_22fc6cf606e48f8fa771c4e8cab49553_R_1;
                    surface.Smoothness = _Lerp_2247e6fe06a85b8098ccf90406a20ab1_Out_3;
                    surface.Occlusion = _Split_22fc6cf606e48f8fa771c4e8cab49553_G_2;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.WorldSpacePosition =          input.positionWS;
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthNormals"
                Tags
                {
                    "LightMode" = "DepthNormals"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 WorldSpacePosition;
                };
                
                void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.WorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.WorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.WorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a87753ad90594382bf3a3a95abbadbc8_Out_2);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2);
                    float3 _Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_e4fe778b81456d819c52bb414cd95968_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float3 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2;
                    Unity_Multiply_float(_Split_6299d4ddcc4c74828aea40a46fdb896e_B_3, -1, _Multiply_de711f4a4614bd89a463b53374cf4036_Out_2);
                    float2 _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0 = float2(_Multiply_de711f4a4614bd89a463b53374cf4036_Out_2, 1);
                    float2 _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_2af6058cc6ccb88caefd2799bb5941e8_Out_2);
                    _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float2 _Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0 = float2(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4, _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5);
                    float2 _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2;
                    Unity_Multiply_float(_Vector2_fe9aedd4528c7486ada4abdca0b0944e_Out_0, _Vector2_4ed33f0c73b2698fa6f3c1b77fe76808_Out_0, _Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2);
                    float2 _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_b227c84042055e8faa1a9fdc69529707_Out_2;
                    Unity_Add_float2(_Multiply_02b9b4665ad9918d8721bcaddc82f06f_Out_2, _Vector2_a74a85274da15181abb63cc5e8df0de1_Out_0, _Add_b227c84042055e8faa1a9fdc69529707_Out_2);
                    float _Split_2cfb9eacd8762483941459cdf28bda97_R_1 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[0];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_G_2 = _Add_b227c84042055e8faa1a9fdc69529707_Out_2[1];
                    float _Split_2cfb9eacd8762483941459cdf28bda97_B_3 = 0;
                    float _Split_2cfb9eacd8762483941459cdf28bda97_A_4 = 0;
                    float _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0 = float3(_Split_2cfb9eacd8762483941459cdf28bda97_R_1, _Split_2cfb9eacd8762483941459cdf28bda97_G_2, _Multiply_1d65ce08ce672087879125f2e13c4004_Out_2);
                    float3 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_R_1, 1);
                    float2 _Multiply_862402885a49f18cb87278ab53bc6744_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_862402885a49f18cb87278ab53bc6744_Out_2);
                    _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float _Multiply_4649b768be76d784a3284bacde795359_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Multiply_4649b768be76d784a3284bacde795359_Out_2);
                    float2 _Vector2_819fcd5eb484438eacad1987576d7d67_Out_0 = float2(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4, _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5);
                    float2 _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2;
                    Unity_Multiply_float(_Vector2_819fcd5eb484438eacad1987576d7d67_Out_0, _Vector2_a1e23e0f921b6484818f009a2b12a5ba_Out_0, _Multiply_58530ebb3c6d798b93686a76247bf505_Out_2);
                    float2 _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2);
                    float2 _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2;
                    Unity_Add_float2(_Multiply_58530ebb3c6d798b93686a76247bf505_Out_2, _Vector2_e293c112b2f49e88a5fe46dfb1fbeb40_Out_0, _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2);
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[0];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2 = _Add_cf00fb232c6e2b8e973ab2f84453f55e_Out_2[1];
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_B_3 = 0;
                    float _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_A_4 = 0;
                    float3 _Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0 = float3(_Multiply_4649b768be76d784a3284bacde795359_Out_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_G_2, _Split_3ea3e61d32bdd78f82c686b75ff3fd9b_R_1);
                    float3 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float3 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float3(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float3 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float3(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float3 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float3(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    float3x3 Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1 = TransformWorldToTangent(_Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2.xyz, Transform_73eecc0c3689d184a34c8d0f28a58adf_tangentTransform_World);
                    float3 _Normalize_15ef346824db0a8797631ed8b998e673_Out_1;
                    Unity_Normalize_float3(_Transform_73eecc0c3689d184a34c8d0f28a58adf_Out_1, _Normalize_15ef346824db0a8797631ed8b998e673_Out_1);
                    XYZ_1 = (float4(_Normalize_15ef346824db0a8797631ed8b998e673_Out_1, 1.0));
                    XZ_2 = (float4(_Vector3_08f62c5c01619e849f1a7d85a44531ac_Out_0, 1.0));
                    YZ_3 = (float4(_Vector3_ba6cfb4671e8c58f9b41ea1dc23102ca_Out_0, 1.0));
                    XY_4 = (float4(_Vector3_13a08d5940172a84a78ee3d9b8766833_Out_0, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 NormalTS;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3;
                    float4 _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XZ_2, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_YZ_3, _TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XY_4);
                    float _Property_7edd97bda70eb38a8c4253094700be37_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8dd9a87de3576e81ba1da2f170dd9cc0_XYZ_1.xyz), _Property_7edd97bda70eb38a8c4253094700be37_Out_0, _NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc.WorldSpacePosition = IN.WorldSpacePosition;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3;
                    float4 _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4;
                    SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XZ_2, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_YZ_3, _TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XY_4);
                    float _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2;
                    Unity_NormalStrength_float((_TriplanarNMn_8890d23c68a4598d85a048422a8f36fc_XYZ_1.xyz), _Property_c3260886a9a91b82a3d14c25e6fd0d2c_Out_0, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_a6bf16c3496e828984e7277239132d42;
                    float3 _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_8bafa3d69de37c818a39fccf03db9518_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, _NormalStrength_d049a259d0377180a2e5959b925a78bc_Out_2, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_a6bf16c3496e828984e7277239132d42, _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.NormalTS = _HeightBlend_a6bf16c3496e828984e7277239132d42_OutVector4_1;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.WorldSpacePosition =          input.positionWS;
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_TEXCOORD2
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 uv2 : TEXCOORD2;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.texCoord0 = input.interp2.xyzw;
                    output.color = input.interp3.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.texCoord0 = input.interp2.xyzw;
                    output.color = input.interp3.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float4 _BaseTilingOffset;
                float _BaseTriplanarThreshold;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2TriplanarThreshold;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A / B;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Absolute_float3(float3 In, out float3 Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Power_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
                {
                    float3 WorldSpaceNormal;
                    float3 AbsoluteWorldSpacePosition;
                };
                
                void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
                {
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float _Property_47988ec10c0c18879d461e00bed806e7_Out_0 = Vector1_41461AC9;
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float3 _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1);
                    float _Split_742547a7039de986a646d04c157ae549_R_1 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[0];
                    float _Split_742547a7039de986a646d04c157ae549_G_2 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[1];
                    float _Split_742547a7039de986a646d04c157ae549_B_3 = _Sign_b826e0ff2d95ec8cb2b2cbbd7ea2eab6_Out_1[2];
                    float _Split_742547a7039de986a646d04c157ae549_A_4 = 0;
                    float2 _Vector2_40a8919e571ec18499de72022c155b38_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_G_2, 1);
                    float2 _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2;
                    Unity_Multiply_float((_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _Vector2_40a8919e571ec18499de72022c155b38_Out_0, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5fa32af59cdca88389832336b2268bd5_Out_2);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float3 _Absolute_644b798714827680b39bf5d34f70385f_Out_1;
                    Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_644b798714827680b39bf5d34f70385f_Out_1);
                    float _Property_adc4c59482221c8aad681c6558728ac9_Out_0 = Vector1_E4D1C13A;
                    float3 _Power_ee478822a04529849ae8df1636c29fe2_Out_2;
                    Unity_Power_float3(_Absolute_644b798714827680b39bf5d34f70385f_Out_1, (_Property_adc4c59482221c8aad681c6558728ac9_Out_0.xxx), _Power_ee478822a04529849ae8df1636c29fe2_Out_2);
                    float3 _Multiply_b386a937554d73828e437d126d69608b_Out_2;
                    Unity_Multiply_float(_Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Power_ee478822a04529849ae8df1636c29fe2_Out_2, _Multiply_b386a937554d73828e437d126d69608b_Out_2);
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[0];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[1];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3 = _Multiply_b386a937554d73828e437d126d69608b_Out_2[2];
                    float _Split_ae83014fcbd9f7879a0b91fa66dc9718_A_4 = 0;
                    float4 _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2.xxxx), _Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2);
                    float4 _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4;
                    float3 _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5;
                    float2 _Combine_192c2c4a69be588b90ca005a32e22552_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, _Combine_192c2c4a69be588b90ca005a32e22552_RGB_5, _Combine_192c2c4a69be588b90ca005a32e22552_RG_6);
                    float4 _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2;
                    Unity_Multiply_float(_Combine_192c2c4a69be588b90ca005a32e22552_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_138240d0d4846e87b0febabec0d6891b_Out_2);
                    float _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2;
                    Unity_Multiply_float(_Split_742547a7039de986a646d04c157ae549_B_3, -1, _Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2);
                    float2 _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0 = float2(_Multiply_014402ded5a3988a8c18ba07636ea5a7_Out_2, 1);
                    float2 _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2;
                    Unity_Multiply_float((_Multiply_138240d0d4846e87b0febabec0d6891b_Out_2.xy), _Vector2_caa25d55d456a58982bdfc39b1b43f3f_Out_0, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float4 _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_a67201b6e1a0a28c98cd9d06e8b09543_Out_2);
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_R_4 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.r;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_G_5 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.g;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_B_6 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.b;
                    float _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_A_7 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0.a;
                    float4 _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3.xxxx), _Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2);
                    float4 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4;
                    float3 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5;
                    float2 _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_B_3, _Split_89ed63cb625cb3878c183d0b71c03400_G_2, 0, 0, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGB_5, _Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RG_6);
                    float4 _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2;
                    Unity_Multiply_float(_Combine_1e9ffdba42d6918fb7a4b185f1585d2a_RGBA_4, (_Property_47988ec10c0c18879d461e00bed806e7_Out_0.xxxx), _Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2);
                    float2 _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0 = float2(_Split_742547a7039de986a646d04c157ae549_R_1, 1);
                    float2 _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2;
                    Unity_Multiply_float((_Multiply_2c0864423b014f8b8af8523f68cbb63c_Out_2.xy), _Vector2_54dfd40df2fc78809955dd272f2cf0c3_Out_0, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float4 _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_addbd5fcede95f80bbb806c94e49ef63_Out_2);
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_R_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.r;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_G_5 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.g;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_B_6 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.b;
                    float _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_A_7 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0.a;
                    float4 _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0, (_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1.xxxx), _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2);
                    float4 _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2;
                    Unity_Add_float4(_Multiply_7bb4009c92b108849ac6ca92bc1442f2_Out_2, _Multiply_77818c22e359fc8cbb7dd20216a8db72_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2);
                    float4 _Add_14295f72880e4b87a1baf1ced943ac40_Out_2;
                    Unity_Add_float4(_Multiply_2e1040ca9c98d085ace76ee93f094039_Out_2, _Add_769d9ee909c9238dbbf72d2800a2f268_Out_2, _Add_14295f72880e4b87a1baf1ced943ac40_Out_2);
                    float _Add_e59af300bba2498db32eac1412123447_Out_2;
                    Unity_Add_float(_Split_ae83014fcbd9f7879a0b91fa66dc9718_R_1, _Split_ae83014fcbd9f7879a0b91fa66dc9718_G_2, _Add_e59af300bba2498db32eac1412123447_Out_2);
                    float _Add_e855069f047fae8ea9027d56acb61e56_Out_2;
                    Unity_Add_float(_Add_e59af300bba2498db32eac1412123447_Out_2, _Split_ae83014fcbd9f7879a0b91fa66dc9718_B_3, _Add_e855069f047fae8ea9027d56acb61e56_Out_2);
                    float4 _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    Unity_Divide_float4(_Add_14295f72880e4b87a1baf1ced943ac40_Out_2, (_Add_e855069f047fae8ea9027d56acb61e56_Out_2.xxxx), _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2);
                    XYZ_1 = _Divide_91ae4b94f1d9b78e99d0472293b8098c_Out_2;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                    YZ_3 = _SampleTexture2D_ba083a478bc22280af2e2cc93ffd5027_RGBA_0;
                    XY_4 = _SampleTexture2D_30c5fd692044ae87b9c4029fa46973fa_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df;
                    float3 _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df, _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_f87cbaf846cb908ca9af419f2ace60df_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_d4a357b2daff5587ae46468726a33797_Out_0 = _BaseTilingOffset;
                    float4 _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_d4a357b2daff5587ae46468726a33797_Out_0, _Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2);
                    float _Property_b168be530d5b4082a2816fc835b55e19_Out_0 = _BaseTriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3;
                    float4 _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XZ_2, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_YZ_3, _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XY_4);
                    float4 _Property_17f0f1bec4ec6485881127275660d4f1_Out_0 = _BaseColor;
                    float4 _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2;
                    Unity_Multiply_float(_TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1, _Property_17f0f1bec4ec6485881127275660d4f1_Out_0, _Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3;
                    float4 _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, (_Divide_c703c79d4bf76e8c9848ea2ecd29211f_Out_2).x, _Property_b168be530d5b4082a2816fc835b55e19_Out_0, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XZ_2, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_YZ_3, _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XY_4);
                    float _Split_866a663ed067f988862843fe32765ff8_R_1 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[0];
                    float _Split_866a663ed067f988862843fe32765ff8_G_2 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[1];
                    float _Split_866a663ed067f988862843fe32765ff8_B_3 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[2];
                    float _Split_866a663ed067f988862843fe32765ff8_A_4 = _TriplanarNM_26fef41c0b7e9a8489d2a70057ea5f5c_XYZ_1[3];
                    float _Property_3b9891099f2f3e84b765eb453f6f6810_Out_0 = _HeightMin;
                    float _Property_bde21360babd9089a90a45cd2843925b_Out_0 = _HeightMax;
                    float2 _Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0 = float2(_Property_3b9891099f2f3e84b765eb453f6f6810_Out_0, _Property_bde21360babd9089a90a45cd2843925b_Out_0);
                    float _Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0 = _HeightOffset;
                    float2 _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2;
                    Unity_Add_float2(_Vector2_9f8e90f51ffcfe8bb3d495766c0cabca_Out_0, (_Property_6ff6d72f7b1d0083b4e4ce61e7e7c8d3_Out_0.xx), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2);
                    float _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3;
                    Unity_Remap_float(_Split_866a663ed067f988862843fe32765ff8_B_3, float2 (0, 1), _Add_39687f6bf7045086bc2d1ccf5f94c9de_Out_2, _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3);
                    float4 _Property_221c724b2137d58c8c387fee5b48be14_Out_0 = _Base2TilingOffset;
                    float4 _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2;
                    Unity_Divide_float4(float4(1, 1, 0, 0), _Property_221c724b2137d58c8c387fee5b48be14_Out_0, _Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2);
                    float _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0 = _Base2TriplanarThreshold;
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_ca3aaaec266f85859b75e37163da7cba;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_ca3aaaec266f85859b75e37163da7cba.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3;
                    float4 _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XZ_2, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_YZ_3, _TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XY_4);
                    float4 _Property_60dff9cc4310ea89874789591a78d84b_Out_0 = _Base2Color;
                    float4 _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2;
                    Unity_Multiply_float(_TriplanarNM_ca3aaaec266f85859b75e37163da7cba_XYZ_1, _Property_60dff9cc4310ea89874789591a78d84b_Out_0, _Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2);
                    float _Property_312b653a29ccc087849b1493611fb73c_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.r;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_G_5 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.g;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_B_6 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.b;
                    float _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_A_7 = _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_RGBA_0.a;
                    float _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1);
                    float _Branch_6b7615e16629338ba87d3570a0096f66_Out_3;
                    Unity_Branch_float(_Property_312b653a29ccc087849b1493611fb73c_Out_0, _OneMinus_bc0b8885b596648d9b594130faa6585c_Out_1, _SampleTexture2D_c910b4b42510578d81c16169d3cb5727_R_4, _Branch_6b7615e16629338ba87d3570a0096f66_Out_3);
                    Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3;
                    float4 _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4;
                    SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, (_Divide_9f3f46254d5f7a8e87f60c4aa6f5522c_Out_2).x, _Property_20f6a96f64098d87b850c83bc45ddcee_Out_0, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XZ_2, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_YZ_3, _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XY_4);
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_R_1 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[0];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_G_2 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[1];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[2];
                    float _Split_0b441b86fba0ea80bc060dae9d7ed0d7_A_4 = _TriplanarNM_e1cbd521c1f2548db05840885a8dbe6b_XYZ_1[3];
                    float _Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0 = _HeightMin2;
                    float _Property_145222f375008a879315637be0f172c5_Out_0 = _HeightMax2;
                    float2 _Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0 = float2(_Property_c1de6a6321562383bfac4b318fc7b0d3_Out_0, _Property_145222f375008a879315637be0f172c5_Out_0);
                    float _Property_8be924d801daee88b294af592a560e75_Out_0 = _HeightOffset2;
                    float2 _Add_37703f1eb9ce078daaedca833705f5dd_Out_2;
                    Unity_Add_float2(_Vector2_416c3ee3a60cc686b2d2360a073acfad_Out_0, (_Property_8be924d801daee88b294af592a560e75_Out_0.xx), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2);
                    float _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3;
                    Unity_Remap_float(_Split_0b441b86fba0ea80bc060dae9d7ed0d7_B_3, float2 (0, 1), _Add_37703f1eb9ce078daaedca833705f5dd_Out_2, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3);
                    float _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2;
                    Unity_Multiply_float(_Branch_6b7615e16629338ba87d3570a0096f66_Out_3, _Remap_5a8467f2416dc98699682a4cf64a69aa_Out_3, _Multiply_d9f42ca072d9188ab2566400157a199f_Out_2);
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1 = IN.VertexColor[0];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_G_2 = IN.VertexColor[1];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3 = IN.VertexColor[2];
                    float _Split_b4d08e724ec3df88ab7743c5b7a3f081_A_4 = IN.VertexColor[3];
                    float _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2;
                    Unity_Multiply_float(_Multiply_d9f42ca072d9188ab2566400157a199f_Out_2, _Split_b4d08e724ec3df88ab7743c5b7a3f081_B_3, _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2);
                    float _Property_c0dc9341fd635288a1c2869945617704_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_d30f443b26dc0d8087616105058c020a;
                    float3 _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_6434c1e27d77608fb8dcec94697eb8d3_Out_2.xyz), _Remap_ddc02d039a9d5388b8add0d2d673d4ac_Out_3, (_Multiply_4d8e3ca1454e2d85963c9d240239a171_Out_2.xyz), _Multiply_55cb55224306dc818a87a2dbf82d5af0_Out_2, _Property_c0dc9341fd635288a1c2869945617704_Out_0, _HeightBlend_d30f443b26dc0d8087616105058c020a, _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1);
                    float4 _Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0 = _WetColor;
                    float3 _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2;
                    Unity_Multiply_float((_Property_2ff5681ef4527d809ef09fdc5f8ef937_Out_0.xyz), _HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2);
                    float _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1;
                    Unity_OneMinus_float(_Split_b4d08e724ec3df88ab7743c5b7a3f081_R_1, _OneMinus_f1784d825dacdb8785770d3eca446428_Out_1);
                    float3 _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    Unity_Lerp_float3(_HeightBlend_d30f443b26dc0d8087616105058c020a_OutVector4_1, _Multiply_85d9904c4b12ce85939f7948252c76b2_Out_2, (_OneMinus_f1784d825dacdb8785770d3eca446428_Out_1.xxx), _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3);
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_R_1 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[0];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_G_2 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[1];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_B_3 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[2];
                    float _Split_2f38c4b6e08da48093bd9896985f29eb_A_4 = _TriplanarNM_2b9b27a1a1bba68194edddb5fe422579_XYZ_1[3];
                    float _Property_a55cb5b55044058c90b91c360cd49672_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_f330c9b8f318a885ac2822e63f9269e8_Out_3;
                    surface.Alpha = _Split_2f38c4b6e08da48093bd9896985f29eb_A_4;
                    surface.AlphaClipThreshold = _Property_a55cb5b55044058c90b91c360cd49672_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        CustomEditor "ShaderGraph.PBRMasterGUI"
        FallBack "Hidden/Shader Graph/FallbackError"
    }