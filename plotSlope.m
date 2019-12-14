function plotSlope(beamType, beamLength, beamWidth, beamHeight, beamMaterialType,elasticMod,inertia, pointForce, udl, windSpeed, fluidType)
    densityOfAir = 1.225;
    densityOfWater = 997;
    densityOfHoney = 1400;
    gravitationalAcceleration = 9.8;
    modElasticitySteel = 200 * power(10,9);
    modElasticityAluminum = 68.9  * power(10,9);
    modElasticityPlatinum = 172 * power(10,9);
        
    area  = beamLength * beamWidth;
    submergedVolume = beamLength * beamWidth * beamHeight;
    if (elasticMod)
        modElasticityChosen = elasticMod;
    else
        if strcmp(beamMaterialType,'steel')
            modElasticityChosen = modElasticitySteel;
        elseif strcmp(beamMaterialType,'aluminum')
            modElasticityChosen = modElasticityAluminum;
        elseif strcmp(beamMaterialType,'platinum')
            modElasticityChosen = modElasticityPlatinum;
        end
    end
    if (windSpeed)
        windLoad = 0.5 * densityOfAir * (windSpeed / 3.6) ^ 2 * area;
        uniformLoad = udl + windLoad;
    else
        uniformLoad = udl;
    end
    if strcmp(fluidType,'honey')
        buoyancyLoad = densityOfHoney * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    elseif strcmp(fluidType,'water')
        buoyancyLoad = densityOfWater * gravitationalAcceleration * submergedVolume;
        uniformLoad = udl - buoyancyLoad;
    end
    if (inertia)
        secondMomentArea = inertia;        
    else
        secondMomentArea = beamWidth * power(beamHeight,3) / 12;
    end    
    x = 0:0.0000001:beamLength;
    slopeFormula = (-uniformLoad * x) .* (3*beamLength^2 - 3*beamLength*x + x.^2) / (6 * modElasticityChosen * secondMomentArea) + (-pointForce * x) .* (2*beamLength - x) / (2 * modElasticityChosen * secondMomentArea);
    
    figure;
    hold on
%     sgtitle('10N Point Load, 50 N/m, Immersed in Honey')
    plot(x,slopeFormula);
%     plot(0,0,'r>','MarkerSize',10);
    title('Slope');
%     xlim([-1 beamLength+1])
%     ylim([-0.000000001+1.5*maxDef 0.000000001+(-2.5)*maxDef])
    xlabel('meter(m)');
    ylabel('radian');
end