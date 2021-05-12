Shader "NatureManufacture/URP/Foliage/Bark"
    {
        Properties
        {
            _TrunkBaseColor("Trunk Base Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_TrunkBaseColorMap("Trunk Base Map", 2D) = "white" {}
            _TrunkTilingOffset("Trunk Tiling and Offset", Vector) = (1, 1, 0, 0)
            [NoScaleOffset]_TrunkNormalMap("Trunk Normal Map", 2D) = "bump" {}
            _TrunkNormalScale("Trunk Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_TrunkMaskMap("Trunk Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
            _TrunkMetallic("Trunk Metallic", Range(0, 1)) = 1
            _TrunkAORemapMin("Trunk AO Remap Min", Range(0, 1)) = 0
            _TrunkAORemapMax("Trunk AO Remap Max", Range(0, 1)) = 1
            _TrunkSmoothnessRemapMin("Trunk Smoothness Remap Min", Range(0, 1)) = 0
            _TrunkSmoothnessRemapMax("Trunk Smoothness Remap Max", Range(0, 1)) = 1
            [NoScaleOffset]_LayerMask("Bark Blend Mask(A)", 2D) = "black" {}
            _BarkBlendMaskTilingOffset("Bark Blend Mask Tiling Offset", Vector) = (1, 1, 0, 0)
            _BarkBaseColor("Bark Base Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_BarkBaseColorMap("Bark Base Map", 2D) = "white" {}
            [ToggleUI]_BarkUseUV3("Bark Use UV3", Float) = 1
            _BarkTilingOffset("Bark Tiling and Offset", Vector) = (1, 1, 0, 0)
            [NoScaleOffset]_BarkNormalMap("Bark Normal Map", 2D) = "bump" {}
            _BarkNormalScale("Bark Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_BarkMaskMap("Bark Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
            _BarkMetallic("Bark Metallic", Range(0, 1)) = 1
            _BarkSmoothnessRemapMin("Bark Smoothness Remap Min", Range(0, 1)) = 0
            _BarkSmoothnessRemapMax("Bark Smoothness Remap Max", Range(0, 1)) = 1
            _BarkAORemapMin("Bark AO Remap Min", Range(0, 1)) = 0
            _BarkAORemapMax("Bark AO Remap Max", Range(0, 1)) = 1
            _Stiffness("Wind Stiffness", Float) = 1
            _InitialBend("Wind Initial Bend", Float) = 0
            _Drag("Wind Drag", Float) = 1
            _HeightDrag("Wind Drag Height Offset", Float) = 0
            _NewNormal("Mesh Normal Multiply", Vector) = (0, 0, 0, 0)
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
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
                    float4 texCoord3;
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
                    float3 TangentSpaceNormal;
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
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
                    output.interp4.xyzw =  input.texCoord3;
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
                    output.texCoord3 = input.interp4.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    float4 _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0);
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_R_4 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.r;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_G_5 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.g;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_B_6 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.b;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_A_7 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.a;
                    float _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0 = _TrunkNormalScale;
                    float3 _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.xyz), _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0, _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2);
                    float4 _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0);
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_R_4 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.r;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_G_5 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.g;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_B_6 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.b;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_A_7 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.a;
                    float _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0 = _BarkNormalScale;
                    float3 _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.xyz), _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2);
                    float3 _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    Unity_Lerp_float3(_NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3);
                    float4 _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkMaskMap, sampler_TrunkMaskMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.r;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.g;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_B_6 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.b;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.a;
                    float _Property_d1f2831d91baa68fa25a43686b68e209_Out_0 = _TrunkMetallic;
                    float _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4, _Property_d1f2831d91baa68fa25a43686b68e209_Out_0, _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2);
                    float _Property_a10a16d5fbc22682919425317aca698d_Out_0 = _TrunkAORemapMin;
                    float _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0 = _TrunkAORemapMax;
                    float2 _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0 = float2(_Property_a10a16d5fbc22682919425317aca698d_Out_0, _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0);
                    float _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5, float2 (0, 1), _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3);
                    float _Property_93db442d827a328c9498fd644c94ec7b_Out_0 = _TrunkSmoothnessRemapMin;
                    float _Property_4959de9b98581488b91bff2b96859515_Out_0 = _TrunkSmoothnessRemapMax;
                    float2 _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0 = float2(_Property_93db442d827a328c9498fd644c94ec7b_Out_0, _Property_4959de9b98581488b91bff2b96859515_Out_0);
                    float _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7, float2 (0, 1), _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float3 _Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0 = float3(_Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float4 _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0 = SAMPLE_TEXTURE2D(_BarkMaskMap, sampler_BarkMaskMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.r;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.g;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_B_6 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.b;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.a;
                    float _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0 = _BarkMetallic;
                    float _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4, _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0, _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2);
                    float _Property_99747f684fd87f88a2d904eb4243680a_Out_0 = _BarkAORemapMin;
                    float _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0 = _BarkAORemapMax;
                    float2 _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0 = float2(_Property_99747f684fd87f88a2d904eb4243680a_Out_0, _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0);
                    float _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5, float2 (0, 1), _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3);
                    float _Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0 = _BarkSmoothnessRemapMin;
                    float _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0 = _BarkSmoothnessRemapMax;
                    float2 _Vector2_e34524416dd31881a1d82856e88c603d_Out_0 = float2(_Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0, _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0);
                    float _Remap_36505decef60d3858196b2dc5d1c341c_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7, float2 (0, 1), _Vector2_e34524416dd31881a1d82856e88c603d_Out_0, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0 = float3(_Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3;
                    Unity_Lerp_float3(_Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0, _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3);
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[0];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[1];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[2];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_A_4 = 0;
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.NormalTS = _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1;
                    surface.Smoothness = _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3;
                    surface.Occlusion = _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2;
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
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
                    float4 texCoord3;
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
                    float3 TangentSpaceNormal;
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
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
                    output.interp4.xyzw =  input.texCoord3;
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
                    output.texCoord3 = input.interp4.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    float4 _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0);
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_R_4 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.r;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_G_5 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.g;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_B_6 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.b;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_A_7 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.a;
                    float _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0 = _TrunkNormalScale;
                    float3 _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.xyz), _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0, _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2);
                    float4 _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0);
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_R_4 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.r;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_G_5 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.g;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_B_6 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.b;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_A_7 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.a;
                    float _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0 = _BarkNormalScale;
                    float3 _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.xyz), _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2);
                    float3 _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    Unity_Lerp_float3(_NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3);
                    float4 _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkMaskMap, sampler_TrunkMaskMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.r;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.g;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_B_6 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.b;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.a;
                    float _Property_d1f2831d91baa68fa25a43686b68e209_Out_0 = _TrunkMetallic;
                    float _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4, _Property_d1f2831d91baa68fa25a43686b68e209_Out_0, _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2);
                    float _Property_a10a16d5fbc22682919425317aca698d_Out_0 = _TrunkAORemapMin;
                    float _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0 = _TrunkAORemapMax;
                    float2 _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0 = float2(_Property_a10a16d5fbc22682919425317aca698d_Out_0, _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0);
                    float _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5, float2 (0, 1), _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3);
                    float _Property_93db442d827a328c9498fd644c94ec7b_Out_0 = _TrunkSmoothnessRemapMin;
                    float _Property_4959de9b98581488b91bff2b96859515_Out_0 = _TrunkSmoothnessRemapMax;
                    float2 _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0 = float2(_Property_93db442d827a328c9498fd644c94ec7b_Out_0, _Property_4959de9b98581488b91bff2b96859515_Out_0);
                    float _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7, float2 (0, 1), _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float3 _Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0 = float3(_Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float4 _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0 = SAMPLE_TEXTURE2D(_BarkMaskMap, sampler_BarkMaskMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.r;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.g;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_B_6 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.b;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.a;
                    float _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0 = _BarkMetallic;
                    float _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4, _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0, _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2);
                    float _Property_99747f684fd87f88a2d904eb4243680a_Out_0 = _BarkAORemapMin;
                    float _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0 = _BarkAORemapMax;
                    float2 _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0 = float2(_Property_99747f684fd87f88a2d904eb4243680a_Out_0, _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0);
                    float _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5, float2 (0, 1), _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3);
                    float _Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0 = _BarkSmoothnessRemapMin;
                    float _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0 = _BarkSmoothnessRemapMax;
                    float2 _Vector2_e34524416dd31881a1d82856e88c603d_Out_0 = float2(_Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0, _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0);
                    float _Remap_36505decef60d3858196b2dc5d1c341c_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7, float2 (0, 1), _Vector2_e34524416dd31881a1d82856e88c603d_Out_0, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0 = float3(_Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3;
                    Unity_Lerp_float3(_Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0, _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3);
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[0];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[1];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[2];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_A_4 = 0;
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.NormalTS = _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1;
                    surface.Smoothness = _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3;
                    surface.Occlusion = _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2;
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
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
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
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
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
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
                    output.interp0.xyzw =  input.texCoord0;
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
                    output.texCoord0 = input.interp0.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
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
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
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
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
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
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
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
                    output.interp0.xyzw =  input.texCoord0;
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
                    output.texCoord0 = input.interp0.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float3 TangentSpaceNormal;
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyz =  input.normalWS;
                    output.interp1.xyzw =  input.tangentWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.texCoord3;
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
                    output.normalWS = input.interp0.xyz;
                    output.tangentWS = input.interp1.xyzw;
                    output.texCoord0 = input.interp2.xyzw;
                    output.texCoord3 = input.interp3.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0);
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_R_4 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.r;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_G_5 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.g;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_B_6 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.b;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_A_7 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.a;
                    float _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0 = _TrunkNormalScale;
                    float3 _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.xyz), _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0, _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0);
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_R_4 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.r;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_G_5 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.g;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_B_6 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.b;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_A_7 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.a;
                    float _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0 = _BarkNormalScale;
                    float3 _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.xyz), _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float3 _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    Unity_Lerp_float3(_NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.NormalTS = _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyzw =  input.texCoord0;
                    output.interp1.xyzw =  input.texCoord3;
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
                    output.texCoord0 = input.interp0.xyzw;
                    output.texCoord3 = input.interp1.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyzw =  input.texCoord0;
                    output.interp1.xyzw =  input.texCoord3;
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
                    output.texCoord0 = input.interp0.xyzw;
                    output.texCoord3 = input.interp1.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
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
                    float4 texCoord3;
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
                    float3 TangentSpaceNormal;
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
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
                    output.interp4.xyzw =  input.texCoord3;
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
                    output.texCoord3 = input.interp4.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    float4 _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0);
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_R_4 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.r;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_G_5 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.g;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_B_6 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.b;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_A_7 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.a;
                    float _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0 = _TrunkNormalScale;
                    float3 _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.xyz), _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0, _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2);
                    float4 _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0);
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_R_4 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.r;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_G_5 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.g;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_B_6 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.b;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_A_7 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.a;
                    float _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0 = _BarkNormalScale;
                    float3 _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.xyz), _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2);
                    float3 _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    Unity_Lerp_float3(_NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3);
                    float4 _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkMaskMap, sampler_TrunkMaskMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.r;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.g;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_B_6 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.b;
                    float _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7 = _SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_RGBA_0.a;
                    float _Property_d1f2831d91baa68fa25a43686b68e209_Out_0 = _TrunkMetallic;
                    float _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_R_4, _Property_d1f2831d91baa68fa25a43686b68e209_Out_0, _Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2);
                    float _Property_a10a16d5fbc22682919425317aca698d_Out_0 = _TrunkAORemapMin;
                    float _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0 = _TrunkAORemapMax;
                    float2 _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0 = float2(_Property_a10a16d5fbc22682919425317aca698d_Out_0, _Property_6b437e51bde09c8a9eaa1cf0315874d3_Out_0);
                    float _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_G_5, float2 (0, 1), _Vector2_65b021cb16cf6083a59157fdfea46327_Out_0, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3);
                    float _Property_93db442d827a328c9498fd644c94ec7b_Out_0 = _TrunkSmoothnessRemapMin;
                    float _Property_4959de9b98581488b91bff2b96859515_Out_0 = _TrunkSmoothnessRemapMax;
                    float2 _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0 = float2(_Property_93db442d827a328c9498fd644c94ec7b_Out_0, _Property_4959de9b98581488b91bff2b96859515_Out_0);
                    float _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3;
                    Unity_Remap_float(_SampleTexture2D_2b272d60f47c9b88b68dbba296da07d3_A_7, float2 (0, 1), _Vector2_2365f5e8b9020a85b6bc1a4204523fdb_Out_0, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float3 _Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0 = float3(_Multiply_9d43c538cd621984a54afc1bb8a822ca_Out_2, _Remap_b335490fdd83b5858f8ffc2d07b8762d_Out_3, _Remap_2a187573dc9ec18ab73eeb8e794202a9_Out_3);
                    float4 _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0 = SAMPLE_TEXTURE2D(_BarkMaskMap, sampler_BarkMaskMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.r;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.g;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_B_6 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.b;
                    float _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7 = _SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_RGBA_0.a;
                    float _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0 = _BarkMetallic;
                    float _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_R_4, _Property_3e62578c4dd29e8a9e4ea698bfbb55db_Out_0, _Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2);
                    float _Property_99747f684fd87f88a2d904eb4243680a_Out_0 = _BarkAORemapMin;
                    float _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0 = _BarkAORemapMax;
                    float2 _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0 = float2(_Property_99747f684fd87f88a2d904eb4243680a_Out_0, _Property_f646f9cb90e8fc8b9bf8ba27330df5e8_Out_0);
                    float _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_G_5, float2 (0, 1), _Vector2_c4398c0d00344989afa8fec5d963bb6b_Out_0, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3);
                    float _Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0 = _BarkSmoothnessRemapMin;
                    float _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0 = _BarkSmoothnessRemapMax;
                    float2 _Vector2_e34524416dd31881a1d82856e88c603d_Out_0 = float2(_Property_fd1021b1bf1dba8f9e94da08ddc09062_Out_0, _Property_942dd17ce976268d80ad0d08bb2a667b_Out_0);
                    float _Remap_36505decef60d3858196b2dc5d1c341c_Out_3;
                    Unity_Remap_float(_SampleTexture2D_5e41186a3f77dd8cb52f40bb441a8fe8_A_7, float2 (0, 1), _Vector2_e34524416dd31881a1d82856e88c603d_Out_0, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0 = float3(_Multiply_3ee5826ca5f49f88a98034264fd62503_Out_2, _Remap_6a4a6dd39e6f1081955112d66f480f62_Out_3, _Remap_36505decef60d3858196b2dc5d1c341c_Out_3);
                    float3 _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3;
                    Unity_Lerp_float3(_Vector3_2b73cbb46cc09a86817650bdf3f108d5_Out_0, _Vector3_d41ecbf099f0b78ead5f8d44ebb9c1ef_Out_0, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3);
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[0];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[1];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3 = _Lerp_44874cfb08f04183bddec5ab51abe087_Out_3[2];
                    float _Split_d40647f4e6f62d8c840fb4eafb1da584_A_4 = 0;
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.NormalTS = _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_d40647f4e6f62d8c840fb4eafb1da584_R_1;
                    surface.Smoothness = _Split_d40647f4e6f62d8c840fb4eafb1da584_B_3;
                    surface.Occlusion = _Split_d40647f4e6f62d8c840fb4eafb1da584_G_2;
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
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
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
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
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
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
                    output.interp0.xyzw =  input.texCoord0;
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
                    output.texCoord0 = input.interp0.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
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
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
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
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
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
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
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
                    output.interp0.xyzw =  input.texCoord0;
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
                    output.texCoord0 = input.interp0.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float3 TangentSpaceNormal;
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyz =  input.normalWS;
                    output.interp1.xyzw =  input.tangentWS;
                    output.interp2.xyzw =  input.texCoord0;
                    output.interp3.xyzw =  input.texCoord3;
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
                    output.normalWS = input.interp0.xyz;
                    output.tangentWS = input.interp1.xyzw;
                    output.texCoord0 = input.interp2.xyzw;
                    output.texCoord3 = input.interp3.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0);
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_R_4 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.r;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_G_5 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.g;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_B_6 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.b;
                    float _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_A_7 = _SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.a;
                    float _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0 = _TrunkNormalScale;
                    float3 _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_54d81ba970bfe989b5748de8f2ca3539_RGBA_0.xyz), _Property_276434bcaa4a4480ab798a55ab76ec3f_Out_0, _NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0);
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_R_4 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.r;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_G_5 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.g;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_B_6 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.b;
                    float _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_A_7 = _SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.a;
                    float _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0 = _BarkNormalScale;
                    float3 _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2;
                    Unity_NormalStrength_float((_SampleTexture2D_1c4a321efaf5268bae88e51f7288287e_RGBA_0.xyz), _Property_672af66b5cf9e48790d3d9a677f53b0f_Out_0, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float3 _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    Unity_Lerp_float3(_NormalStrength_701ea5c499a55b85b502ac8a25ea9138_Out_2, _NormalStrength_81a324dedf3885809fc9a9869cd7e92d_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxx), _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.NormalTS = _Lerp_5d0113d39b95a9838b4b587ec3988141_Out_3;
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyzw =  input.texCoord0;
                    output.interp1.xyzw =  input.texCoord3;
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
                    output.texCoord0 = input.interp0.xyzw;
                    output.texCoord3 = input.interp1.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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
                #define ATTRIBUTES_NEED_TEXCOORD3
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_TEXCOORD3
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
                    float4 uv3 : TEXCOORD3;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 texCoord0;
                    float4 texCoord3;
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
                    float4 uv0;
                    float4 uv3;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float3 ObjectSpacePosition;
                    float4 VertexColor;
                    float3 TimeParameters;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float4 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
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
                    output.interp0.xyzw =  input.texCoord0;
                    output.interp1.xyzw =  input.texCoord3;
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
                    output.texCoord0 = input.interp0.xyzw;
                    output.texCoord3 = input.interp1.xyzw;
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
                float4 _TrunkBaseColor;
                float4 _TrunkBaseColorMap_TexelSize;
                float4 _TrunkTilingOffset;
                float4 _TrunkNormalMap_TexelSize;
                float _TrunkNormalScale;
                float4 _TrunkMaskMap_TexelSize;
                float _TrunkMetallic;
                float _TrunkAORemapMin;
                float _TrunkAORemapMax;
                float _TrunkSmoothnessRemapMin;
                float _TrunkSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float4 _BarkBlendMaskTilingOffset;
                float4 _BarkBaseColor;
                float4 _BarkBaseColorMap_TexelSize;
                float _BarkUseUV3;
                float4 _BarkTilingOffset;
                float4 _BarkNormalMap_TexelSize;
                float _BarkNormalScale;
                float4 _BarkMaskMap_TexelSize;
                float _BarkMetallic;
                float _BarkSmoothnessRemapMin;
                float _BarkSmoothnessRemapMax;
                float _BarkAORemapMin;
                float _BarkAORemapMax;
                float _Stiffness;
                float _InitialBend;
                float _Drag;
                float _HeightDrag;
                float4 _NewNormal;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_TrunkBaseColorMap);
                SAMPLER(sampler_TrunkBaseColorMap);
                TEXTURE2D(_TrunkNormalMap);
                SAMPLER(sampler_TrunkNormalMap);
                TEXTURE2D(_TrunkMaskMap);
                SAMPLER(sampler_TrunkMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_BarkBaseColorMap);
                SAMPLER(sampler_BarkBaseColorMap);
                TEXTURE2D(_BarkNormalMap);
                SAMPLER(sampler_BarkNormalMap);
                TEXTURE2D(_BarkMaskMap);
                SAMPLER(sampler_BarkMaskMap);
                float WIND_SETTINGS_GustWorldScale;
                float WIND_SETTINGS_GustScale;
                float WIND_SETTINGS_GustSpeed;
                float WIND_SETTINGS_Turbulence;
                float WIND_SETTINGS_ShiverNoiseScale;
                float WIND_SETTINGS_FlexNoiseScale;
                float4 WIND_SETTINGS_WorldDirectionAndSpeed;
                TEXTURE2D(WIND_SETTINGS_TexGust);
                SAMPLER(samplerWIND_SETTINGS_TexGust);
                float4 WIND_SETTINGS_TexGust_TexelSize;
                TEXTURE2D(WIND_SETTINGS_TexNoise);
                SAMPLER(samplerWIND_SETTINGS_TexNoise);
                float4 WIND_SETTINGS_TexNoise_TexelSize;
                SAMPLER(_SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 37bd0fb96975d9185f768b4152bc7b90
                #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
                {
                };
                
                void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Comparison_Greater_float(float A, float B, out float Out)
                {
                    Out = A > B ? 1 : 0;
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Comparison_Less_float(float A, float B, out float Out)
                {
                    Out = A < B ? 1 : 0;
                }
                
                void Unity_And_float(float A, float B, out float Out)
                {
                    Out = A && B;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Length_float4(float4 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A - B;
                }
                
                void Unity_Power_float(float A, float B, out float Out)
                {
                    Out = pow(A, B);
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Or_float(float A, float B, out float Out)
                {
                    Out = A || B;
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Length_float3(float3 In, out float Out)
                {
                    Out = length(In);
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
                {
                };
                
                void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
                {
                    float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
                    float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
                    float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
                    float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
                    float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
                    Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
                    float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
                    Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
                    float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
                    float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
                    float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
                    float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
                    float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
                    Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
                    float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
                    float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
                    float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
                    float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
                    float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
                    Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
                    float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
                    Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
                    float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
                    float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
                    Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
                    float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
                    float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
                    float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
                    float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
                    Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_A3874DB9, samplerTexture2D_A3874DB9, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
                    float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
                    float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
                    Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
                    float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
                    Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
                    float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
                    float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
                    Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
                    float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
                    Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
                    float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
                    float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
                    Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
                    float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
                    Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
                    float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
                    float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
                    float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
                    float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
                    float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
                    float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
                    Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
                    float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
                    float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
                    Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
                    float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
                    Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
                    float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
                    float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
                    Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
                    float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
                    Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
                    float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
                    Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
                    float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
                    float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
                    Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
                    float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
                    float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
                    float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
                    float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
                    Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
                    #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                    #else
                      float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(Texture2D_5BAC276D, samplerTexture2D_5BAC276D, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
                    #endif
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
                    float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
                    float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
                    float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
                    float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
                    Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
                    float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
                    Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
                    float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
                    Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
                    float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
                    float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
                    Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
                    float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
                    Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
                    float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
                    float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
                    float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
                    Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
                    float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
                    float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
                    Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
                    float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                    Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
                    direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
                    strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
                }
                
                void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
                {
                    Out = cross(A, B);
                }
                
                void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
                {
                    Out = dot(A, B);
                }
                
                void Unity_Distance_float3(float3 A, float3 B, out float Out)
                {
                    Out = distance(A, B);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Absolute_float(float In, out float Out)
                {
                    Out = abs(In);
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Cosine_float(float In, out float Out)
                {
                    Out = cos(In);
                }
                
                void Unity_Sine_float(float In, out float Out)
                {
                    Out = sin(In);
                }
                
                void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
                {
                    Out = A != B ? 1 : 0;
                }
                
                struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
                {
                    float3 ObjectSpaceNormal;
                    float3 WorldSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 WorldSpaceTangent;
                    float3 ObjectSpaceBiTangent;
                    float3 WorldSpaceBiTangent;
                    float4 VertexColor;
                };
                
                void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, TEXTURE2D_PARAM(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), float4 Texture2D_5BAC276D_TexelSize, TEXTURE2D_PARAM(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), float4 Texture2D_A3874DB9_TexelSize, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
                {
                    float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
                    float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
                    float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
                    float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
                    float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
                    float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
                    float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
                    Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
                    float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
                    float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
                    float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
                    float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
                    float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
                    float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
                    Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
                    float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
                    Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
                    float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
                    Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
                    float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
                    float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
                    Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
                    float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
                    float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
                    float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
                    Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
                    float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
                    Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
                    float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
                    float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
                    float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
                    Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
                    float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
                    Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
                    float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
                    Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
                    float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
                    float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
                    float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
                    float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
                    float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
                    float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
                    Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
                    float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
                    float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
                    SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, TEXTURE2D_ARGS(Texture2D_5BAC276D, samplerTexture2D_5BAC276D), Texture2D_5BAC276D_TexelSize, TEXTURE2D_ARGS(Texture2D_A3874DB9, samplerTexture2D_A3874DB9), Texture2D_A3874DB9_TexelSize, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
                    float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
                    Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
                    float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
                    Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
                    float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
                    float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
                    Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
                    float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
                    Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
                    float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
                    Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
                    float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
                    Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
                    float _Distance_702b068f612c7289a99272879da274ed_Out_2;
                    Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
                    float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
                    float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
                    Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
                    float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
                    Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
                    float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
                    float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
                    Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
                    float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
                    Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
                    float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
                    Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
                    float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
                    Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
                    float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
                    Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
                    float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
                    Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
                    float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
                    Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
                    float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
                    Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
                    float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
                    Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
                    float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
                    Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
                    float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
                    Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
                    float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
                    float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
                    float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
                    Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
                    float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
                    Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
                    float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
                    Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
                    float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                    Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
                    vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
                    normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void CrossFade_float(out float fadeValue)
                {
                    if(unity_LODFade.x > 0){
                    fadeValue = unity_LODFade.x;
                    }
                    else{
                    fadeValue = 1;
                    }
                }
                
                
                float2 Unity_GradientNoise_Dir_float(float2 p)
                {
                    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
                    p = p % 289;
                    // need full precision, otherwise half overflows when p > 1
                    float x = float(34 * p.x + 1) * p.x % 289 + p.y;
                    x = (34 * x + 1) * x % 289;
                    x = frac(x / 41) * 2 - 1;
                    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
                }
                
                void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                { 
                    float2 p = UV * Scale;
                    float2 ip = floor(p);
                    float2 fp = frac(p);
                    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
                
                struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
                {
                    half4 uv0;
                };
                
                void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
                {
                    float _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
                    CrossFade_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
                    float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
                    Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
                    float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
                    Unity_Multiply_float(_CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
                    float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
                    float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
                    Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
                    Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
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
                    Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f;
                    float3 _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1;
                    SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1);
                    float _Property_d0aed353fc0d6087ba3c134799889809_Out_0 = _Drag;
                    float _Property_8698aa98d732508cb16465acc97a3e86_Out_0 = _HeightDrag;
                    float _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0 = _Stiffness;
                    float _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0 = _InitialBend;
                    float4 _Property_80c400d1da7fd382a8d664e2feb9323a_Out_0 = _NewNormal;
                    float4 _Property_97f6b51572efce84b654b0775d03b84c_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
                    float _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0 = WIND_SETTINGS_FlexNoiseScale;
                    float _Property_27973d3e31abd0878d2a7d2771be7104_Out_0 = WIND_SETTINGS_Turbulence;
                    float _Property_24e4685ff6e47186b970b8d558b4c498_Out_0 = WIND_SETTINGS_GustSpeed;
                    float _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0 = WIND_SETTINGS_GustScale;
                    float _Property_132d2d9a456cd8829b326cb5ad899508_Out_0 = WIND_SETTINGS_GustWorldScale;
                    Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_b359abef47ec45809b991323244cdb1c;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceNormal = IN.ObjectSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceTangent = IN.ObjectSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _WindNMNoShiver_b359abef47ec45809b991323244cdb1c.VertexColor = IN.VertexColor;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
                    float3 _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2;
                    SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_3f3c3e3821eb09889ff3243f4b16a55f_ObjectSpacePosition_1, _Property_d0aed353fc0d6087ba3c134799889809_Out_0, _Property_8698aa98d732508cb16465acc97a3e86_Out_0, 0, _Property_dd1135aac4d9ca898ec8843523c6fce6_Out_0, _Property_3b8efec7a317c48db4117a1c15dd378d_Out_0, (_Property_80c400d1da7fd382a8d664e2feb9323a_Out_0.xyz), TEXTURE2D_ARGS(WIND_SETTINGS_TexNoise, samplerWIND_SETTINGS_TexNoise), WIND_SETTINGS_TexNoise_TexelSize, TEXTURE2D_ARGS(WIND_SETTINGS_TexGust, samplerWIND_SETTINGS_TexGust), WIND_SETTINGS_TexGust_TexelSize, _Property_97f6b51572efce84b654b0775d03b84c_Out_0, _Property_163404c60fb6718e8d4332f7ed0dab02_Out_0, _Property_27973d3e31abd0878d2a7d2771be7104_Out_0, _Property_24e4685ff6e47186b970b8d558b4c498_Out_0, _Property_9f63bfb91b3f248697df5be4b34017d8_Out_0, _Property_132d2d9a456cd8829b326cb5ad899508_Out_0, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1, _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_normal_2);
                    description.Position = _WindNMNoShiver_b359abef47ec45809b991323244cdb1c_vertex_1;
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
                    float4 _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0 = _TrunkTilingOffset;
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[0];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[1];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[2];
                    float _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4 = _Property_48c1c6a2f33b3784ac40094b47329c27_Out_0[3];
                    float2 _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_R_1, _Split_7ec5bf01c018b78499cb09dfe0c85a07_G_2);
                    float2 _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0 = float2(_Split_7ec5bf01c018b78499cb09dfe0c85a07_B_3, _Split_7ec5bf01c018b78499cb09dfe0c85a07_A_4);
                    float2 _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_058647e8fee3b98ab21fa192075f97da_Out_0, _Vector2_743d6a3034d21d8a81e6a39570dfb653_Out_0, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float4 _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_5257aafcb80b4886ad8796b618586544_Out_3);
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_R_4 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.r;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_G_5 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.g;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_B_6 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.b;
                    float _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_A_7 = _SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0.a;
                    float4 _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0 = _TrunkBaseColor;
                    float4 _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_4e56ffa3a53d378698371a0a0f4b7545_RGBA_0, _Property_6c80cfc2ce3bae86a1e24e04191662a7_Out_0, _Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2);
                    float _Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0 = _BarkUseUV3;
                    float4 _UV_d512b403868e998b81ba8e50fc0aef56_Out_0 = IN.uv3;
                    float4 _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0 = IN.uv0;
                    float4 _Branch_54882a9d8ae3378792467a0f698aa970_Out_3;
                    Unity_Branch_float4(_Property_ebff9413c8e8488890fcdca9fc9ca515_Out_0, _UV_d512b403868e998b81ba8e50fc0aef56_Out_0, _UV_65dc0aa6dbce5a859a792840f4a3ab6d_Out_0, _Branch_54882a9d8ae3378792467a0f698aa970_Out_3);
                    float4 _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0 = _BarkTilingOffset;
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_R_1 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[0];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_G_2 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[1];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_B_3 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[2];
                    float _Split_984d23228d957e8a8ffa9a38b9efc457_A_4 = _Property_00fd67825d90d48fae1c7d02c5f5191f_Out_0[3];
                    float2 _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_R_1, _Split_984d23228d957e8a8ffa9a38b9efc457_G_2);
                    float2 _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0 = float2(_Split_984d23228d957e8a8ffa9a38b9efc457_B_3, _Split_984d23228d957e8a8ffa9a38b9efc457_A_4);
                    float2 _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3;
                    Unity_TilingAndOffset_float((_Branch_54882a9d8ae3378792467a0f698aa970_Out_3.xy), _Vector2_43c3046e533e4d8da736d112fab24a6b_Out_0, _Vector2_a6e940c952a9fe8e8707e64c1d767664_Out_0, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float4 _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_d35566bfe3ddf083a228e03813657066_Out_3);
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_R_4 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.r;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_G_5 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.g;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_B_6 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.b;
                    float _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_A_7 = _SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0.a;
                    float4 _Property_7b3429139819628f85b839fbc09d9bc6_Out_0 = _BarkBaseColor;
                    float4 _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_de82c6e60e4e4283a0987a5b7b5060d4_RGBA_0, _Property_7b3429139819628f85b839fbc09d9bc6_Out_0, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2);
                    float4 _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0 = _BarkBlendMaskTilingOffset;
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_R_1 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[0];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_G_2 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[1];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_B_3 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[2];
                    float _Split_a3e74b96191a4b80839bea612f38bcbe_A_4 = _Property_b5f6bcebb8b32e89b52c3f85783ded0a_Out_0[3];
                    float2 _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_R_1, _Split_a3e74b96191a4b80839bea612f38bcbe_G_2);
                    float2 _Vector2_16901e853dda948ab43853d9368f8779_Out_0 = float2(_Split_a3e74b96191a4b80839bea612f38bcbe_B_3, _Split_a3e74b96191a4b80839bea612f38bcbe_A_4);
                    float2 _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_859a54707b3664838b6a520989d7bfd2_Out_0, _Vector2_16901e853dda948ab43853d9368f8779_Out_0, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float4 _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_f833fa635f96ba808068c46bda4db69e_Out_3);
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_R_4 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.r;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_G_5 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.g;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_B_6 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.b;
                    float _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7 = _SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_RGBA_0.a;
                    float4 _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3;
                    Unity_Lerp_float4(_Multiply_aae3cf539d61eb8b8895bf354f11ecd7_Out_2, _Multiply_9b2771977cc40c83a6e8b9c3c1f8bdc6_Out_2, (_SampleTexture2D_184a6002a351e680a96d2c1da5a068b3_A_7.xxxx), _Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3);
                    Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_584e05355732048fa6dca6e9cf9b985f;
                    _CrossFade_584e05355732048fa6dca6e9cf9b985f.uv0 = IN.uv0;
                    float _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_584e05355732048fa6dca6e9cf9b985f, _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1);
                    surface.BaseColor = (_Lerp_eb87b86a4ad34c89b5802ebc1d0ca8e6_Out_3.xyz);
                    surface.Alpha = _CrossFade_584e05355732048fa6dca6e9cf9b985f_Alpha_1;
                    surface.AlphaClipThreshold = 0.5;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
                    output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
                    output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
                    output.ObjectSpacePosition =         input.positionOS;
                    output.VertexColor =                 input.color;
                    output.TimeParameters =              _TimeParameters.xyz;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.uv0 =                         input.texCoord0;
                    output.uv3 =                         input.texCoord3;
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