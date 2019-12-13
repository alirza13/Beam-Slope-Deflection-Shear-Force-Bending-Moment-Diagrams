function plotShearForce(beamType, beamLength, beamWidth, beamHeight, beamMaterialType,elasticMod,inertia, pointForce, udl, windSpeed, fluidType)
    densityOfAir = 1.225;
    densityOfWater = 997;
    densityOfHoney = 1400;
    gravitationalAcceleration = 9.8;
    modElasticitySteel = 100 * power(10,-6);
    modElasticityAluminum = 100 * power(10,-6);
    modElasticityPlatinum = 100 * power(10,-6);
    
    area  = beamLength * beamWidth;
    submergedVolume = beamLength * beamWidth * beamHeight;
    if (windSpeed)
        windLoad = 0.5 * densityOfAir * (windSpeed / 3.6 ) ^ 2 * area;
        uniformLoad = udl + windLoad;
    end
    if strcmp(fluidType,'honey')
        buoyancyLoad = densityOfHoney * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    elseif strcmp(fluidType,'water')
        buoyancyLoad = densityOfWater * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    end
    if (inertia)
        secondMomentArea = b * power(height,3) / 12;
    else
        secondMomentArea = inertia;
    end    
    x = 0:0.000000001:beamLength;
    
end