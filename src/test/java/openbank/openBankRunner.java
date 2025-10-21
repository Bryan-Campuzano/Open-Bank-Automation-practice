package openbank;

import com.intuit.karate.junit5.Karate;

class openBankRunner {
    @Karate.Test
    Karate runOpenBankFeature() {
        return Karate.run("classpath:features/RegistroUsuario.feature");
    }
}



