package OpenBankTest;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

class OpenBankTest {

    @org.junit.jupiter.api.Test
    void runAllFeatures() {
        List<String> validFeatures = new ArrayList<>();
        File baseDir = new File("src/test/resources/features");

        for (File folder : baseDir.listFiles()) {
            if (folder.isDirectory()) {
                for (File f : folder.listFiles((dir, name) -> name.endsWith(".feature"))) {
                    if (f.length() > 10) { // evita vacíos o casi vacíos
                        validFeatures.add("classpath:features/" + folder.getName() + "/" + f.getName());
                    } else {
                        System.out.println("⚠️ Saltando feature vacío: " + f.getName());
                    }
                }
            }
        }

        Results results = Runner.path(validFeatures).parallel(4);
        System.out.println("✅ Passed: " + results.getScenariosPassed());
        System.out.println("❌ Failed: " + results.getFailCount());

        if (results.getFailCount() > 0) {
            throw new RuntimeException("Some features failed");
        }
    }
}
