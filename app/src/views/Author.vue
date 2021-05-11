<template>
  <section style="height: 100%" class="px-8">
    <circular-progress v-if="loading" />
    <v-container v-else>
      <div class="d-flex align-end">
        <v-avatar size="100" class="mr-6">
          <v-img :src="getImage"></v-img>
        </v-avatar>
        <div>
          <h1 class="mb-2">
            {{ getAuthor.fullName }} - ( {{ getAuthor.birthYear }} )
          </h1>
          <div class="google-sans-regular font-italic">
            Country: {{ getAuthor.countryName ? getAuthor.countryName : "..." }}
          </div>
        </div>
      </div>

      <v-divider class="my-4 mb-6"></v-divider>
      <h1 class="text-center">📔 Books 📔</h1>
      <book-list :bookInfos="getBookInfosByAuthor" :updateable="false" />
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import BookList from "../components/Book/BookList.vue";
import CircularProgress from "../components/Core/CircularProgress.vue";
export default {
  name: "Author",
  components: { BookList, CircularProgress },
  data() {
    return {
      loading: false,
    };
  },

  methods: {
    ...mapActions("book", ["bindBookInfos"]),
  },
  computed: {
    ...mapGetters("author", ["getAuthor"]),
    ...mapGetters("book", ["getBookInfosByAuthor"]),
    getImage() {
      try {
        return require(`@/assets/upload/img/${this.getAuthor.image}`);
      } catch (err) {
        return require("@/assets/upload/img/book/default_book_cover.jpg");
      }
    },
  },
  async mounted() {
    this.loading = true;
    await this.bindBookInfos({
      authorId: this.getAuthor.authorId,
    });
    this.loading = false;
  },
};
</script>

<style>
</style>